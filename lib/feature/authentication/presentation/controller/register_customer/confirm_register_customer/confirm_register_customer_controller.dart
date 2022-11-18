import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/register_request%20.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/domain/usecases/register_usecase.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/services/storage_service.dart';
import 'package:permission_handler/permission_handler.dart';

class ConfirmRegisterCustomerController extends BaseController<RegisterRequest> {
  ConfirmRegisterCustomerController(this._registerUserCase, this._storageService);

  final RegisterUsecase _registerUserCase;
  final StorageService _storageService;

  var phoneNumber = "".obs;
  RegisterRequest? registerRequest;

  var isChecking = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    phoneNumber.value = input.phoneNumber!;
    registerRequest = input;
    countDown();
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

  void checkOTP(BuildContext context, String otpCode) async {
    isChecking.value = true;
    hideKeyboard();
    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: registerRequest!.verificationId!, smsCode: otpCode);
    var userCredential = await FirebaseAuth.instance.signInWithCredential(credential).catchError((error) {
      showErrorDialog(context, "Mã xác thực không chính xác");
      isChecking.value = false;
    });

    if (userCredential.user != null) {
      onRegister(context);
    }
  }

  void onRegister(BuildContext context) {
    _registerUserCase.execute(
      observer: Observer(
        onSubscribe: () {},
        onSuccess: (account) {
          isChecking.value = false;
          _storageService.setToken(account.toJson().toString());
          Permission.locationWhenInUse.status.then((value) {
            if (value.isGranted) {
              N.toTabBar(account: account);
            } else {
              N.toPermissionHandler(account: account);
            }
          });
        },
        onError: (e) {
          isChecking.value = false;
          if (e is DioError) {
            if (e.response != null) {
              showErrorDialog(context, e.response!.data['detail'].toString());
            } else {
              showErrorDialog(context, e.message);
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

  void showErrorDialog(BuildContext context, String? content) {
    hideKeyboard();
    showOkAlertDialog(
      context: context,
      title: "Xác nhận đăng ký thất bại",
      message: content ?? "Vui lòng thực hiện đâng ký lại sau",
    );
  }
}
