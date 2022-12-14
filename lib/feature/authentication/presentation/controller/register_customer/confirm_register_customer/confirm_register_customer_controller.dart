import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/register_request%20.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/domain/usecases/register_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_customer_info.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_shipper_info_usecase.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/services/storage_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';

class ConfirmRegisterCustomerController extends BaseController<RegisterRequest> {
  ConfirmRegisterCustomerController(
      this._registerUserCase, this._storageService, this._getCustomeInfoUsecase, this._getShipperInfoUsecase);

  final RegisterUsecase _registerUserCase;
  final StorageService _storageService;
  final GetShipperInfoUsecase _getShipperInfoUsecase;
  final GetCustomeInfoUsecase _getCustomeInfoUsecase;
  var iosOTP = -1;
  var phoneNumber = "".obs;
  RegisterRequest? registerRequest;

  var isChecking = false.obs;

  @override
  void onInit() {
    super.onInit();
    phoneNumber.value = input.phoneNumber!;
    registerRequest = input;
    countDown();
    Future.delayed(const Duration(seconds: 2)).then(
      (value) {
        showIosOTP();
      },
    );
  }

  void showIosOTP() {
    if (Platform.isIOS) {
      Random rnd;
      int min = 111111;
      int max = 999999;
      rnd = Random();
      iosOTP = min + rnd.nextInt(max - min);
      Get.snackbar(
        'GoShip',
        '$iosOTP l?? m?? x??c nh???n c???a b???n',
        duration: const Duration(seconds: 15),
      );
    }
  }

  var isResend = true.obs;
  var resendTimer = 60.obs;

  void countDown() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (resendTimer.value > 0) {
          resendTimer.value--;
        } else {
          isResend.value = false;
        }
      },
    );
  }

  void resendOTP() async {
    isResend.value = true;
    resendTimer.value = 60;
    String phone = registerRequest!.phoneNumber!;
    if (phone.substring(0, 1) == "0") {
      phone = "+84${phone.substring(1)}";
    }
    showIosOTP();
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      timeout: const Duration(seconds: 20),
      codeSent: (String verificationId, int? resendToken) {
        registerRequest!.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void checkOTP(String otpCode) async {
    isChecking.value = true;
    hideKeyboard();
    if (Platform.isIOS) {
      if (otpCode == '$iosOTP') {
        onRegister();
      } else {
        showErrorDialog("M?? x??c th???c kh??ng ch??nh x??c");
        isChecking.value = false;
      }
      return;
    }
    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: registerRequest!.verificationId!, smsCode: otpCode);
    var userCredential = await FirebaseAuth.instance.signInWithCredential(credential).catchError((error) {
      showErrorDialog("M?? x??c th???c kh??ng ch??nh x??c");
      isChecking.value = false;
    });

    if (userCredential.user != null) {
      onRegister();
    }
  }

  void onRegister() {
    _registerUserCase.execute(
      observer: Observer(
        onSubscribe: () {},
        onSuccess: (account) {
          AppConfig.accountInfo = account;
          if (registerRequest!.role == 1) {
            _storageService.setToken(account.toJson().toString());
            _getCustomeInfoUsecase.execute(
              observer: Observer(
                onSuccess: (customerModel) async {
                  AppConfig.customerInfo = customerModel;
                  Permission.locationWhenInUse.status.then((value) {
                    if (value.isGranted) {
                      N.toTabBar();
                    } else {
                      N.toPermissionHandler(account: account);
                    }
                  });
                },
                onError: (e) async {
                  if (kDebugMode) {
                    print(e);
                  }
                  await showOkDialog(
                    title: 'L???i h??? th???ng',
                    message: 'Opps! H??? th???ng g???p m???t s??? tr???c tr???c vui l??ng th???c hi???n ????ng nh???p l???i sau',
                  );
                  N.toWelcomePage();
                },
              ),
            );
          } else {
            isChecking.value = false;

            showOkCancelDialog(
              cancelText: "H???y",
              okText: "Ti???p t???c",
              message: "Vui l??ng x??c th???c th??ng tin c?? nh??n ????? ch??nh th???c tr??? th??nh ?????i t??c c???a Go Ship?",
              title: "????ng k?? t??i kho???n th??nh c??ng",
            ).then((value) {
              if (value == OkCancelResult.ok) {
                _storageService.setToken(account.toJson().toString()).then((value) {
                  _getShipperInfoUsecase.execute(
                    observer: Observer(
                      onSubscribe: () {},
                      onSuccess: (shipper) async {
                        AppConfig.shipperInfo = shipper;
                        N.toConfirmShipper();
                      },
                      onError: (e) async {
                        if (kDebugMode) {
                          print(e);
                        }
                        await showOkDialog(
                          title: 'L???i h??? th???ng',
                          message: 'Opps! H??? th???ng g???p m???t s??? tr???c tr???c vui l??ng th???c hi???n ????ng nh???p l???i sau',
                        );
                        N.toWelcomePage();
                      },
                    ),
                  );
                });
              } else {}
            });
          }
        },
        onError: (e) {
          isChecking.value = false;
          if (e is DioError) {
            if (e.response != null) {
              showErrorDialog(e.response!.data['detail'].toString());
            } else {
              showErrorDialog(e.message);
            }
          }
          if (kDebugMode) {
            print(e.toString());
          }
        },
      ),
      input: RegisterRequest(registerRequest!.phoneNumber, registerRequest!.password, registerRequest!.role),
    );
  }

  void showErrorDialog(String? content) {
    hideKeyboard();
    showOkDialog(
      title: "X??c nh???n ????ng k?? th???t b???i",
      message: content ?? "Vui l??ng th???c hi???n ????ng k?? l???i sau",
    );
  }
}
