import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/account_model.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/phone_password_request.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_shipper_info_usecase.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/extension/form_builder.dart';
import 'package:flutter_go_ship_pbl6/utils/services/storage_service.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../domain/usecases/login_usecase.dart';

class LoginController extends BaseController {
  LoginController(this._loginUsecase, this._storageService, this._getShipperInfoUsecase);

  final LoginUsecase _loginUsecase;
  final StorageService _storageService;
  final GetShipperInfoUsecase _getShipperInfoUsecase;

  final phoneTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final formKey = GlobalKey<FormBuilderState>();
  final loginState = BaseState();

  String get _phone => phoneTextEditingController.text;
  String get _password => passwordTextEditingController.text;

  final isDisableButton = true.obs;
  final ignoringPointer = false.obs;
  final errorMessage = ''.obs;
  final isShowPassword = true.obs;

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      phoneTextEditingController.text = '0384933379';
      passwordTextEditingController.text = '123123';
    }
  }

  @override
  void onClose() {
    phoneTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.onClose();
  }

  void onTapShowPassword() {
    isShowPassword.value = !isShowPassword.value;
  }

  void hideErrorMessage() {
    errorMessage.value = '';
  }

  void updateLoginButtonState() {
    isDisableButton.value = _phone.isEmpty || _password.isEmpty;
  }

  void onTapLogin() {
    try {
      final fbs = formKey.formBuilderState!;
      final phoneField = FormFieldType.phone.field(fbs);
      final passwordField = FormFieldType.password.field(fbs);
      [
        phoneField,
        passwordField,
      ].validateFormFields();

      if (loginState.isLoading) return;

      _loginUsecase.execute(
        observer: Observer(
          onSubscribe: () {
            loginState.onLoading();
            ignoringPointer.value = true;
            hideErrorMessage();
          },
          onSuccess: (account) async {
            AppConfig.accountModel = account;

            _storageService.setToken(account.toJson().toString());
            if (account.role == 1) {
              await checkPermisson(account);
            } else {
              _getShipperInfoUsecase.execute(
                observer: Observer(
                  onSubscribe: () {},
                  onSuccess: (shipper) async {
                    await _storageService.setShipper(shipper.toJson().toString());
                    if (shipper.confirmed == 0) {
                      N.toConfirmShipper();
                    } else if (shipper.confirmed == 1) {
                      N.toStatusConfirm(isDeny: false);
                    } else if (shipper.confirmed == 2) {
                      await checkPermisson(account);
                    } else {
                      N.toStatusConfirm(isDeny: true);
                    }
                    ignoringPointer.value = false;
                  },
                  onError: (e) {
                    if (e is DioError) {
                      if (e.response != null) {
                        _showToastMessage(e.response!.data['detail'].toString());
                      } else {
                        _showToastMessage(e.message);
                      }
                    }
                    if (kDebugMode) {
                      print(e.toString());
                    }
                    ignoringPointer.value = false;
                    loginState.onSuccess();
                  },
                ),
              );
            }
          },
          onError: (e) {
            if (e is DioError) {
              if (e.response != null) {
                _showToastMessage(e.response!.data['detail'].toString());
              } else {
                _showToastMessage(e.message);
              }
            }
            if (kDebugMode) {
              print(e.toString());
            }
            ignoringPointer.value = false;
            loginState.onSuccess();
          },
        ),
        input: PhonePasswordRequest(
          _phone.trim(),
          _password.trim(),
        ),
      );
    } on Exception catch (e) {
      isDisableButton.value = true;
    }
  }

  Future<void> checkPermisson(AccountModel account) async {
    final permissionStatus = await Permission.locationWhenInUse.status;
    if (permissionStatus.isGranted) {
      N.toTabBar(account: account);
    } else {
      N.toPermissionHandler(account: account);
    }
  }

  void _showToastMessage(String message) {
    loginState.onError(message);
    ignoringPointer.value = false;
    errorMessage.value = message;
  }

  void resetDataTextField() {
    hideErrorMessage();
    passwordTextEditingController.text = '';
  }
}
