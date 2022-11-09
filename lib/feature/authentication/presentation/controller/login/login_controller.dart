import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/phone_password_request.dart';
import 'package:flutter_go_ship_pbl6/utils/extension/form_builder.dart';
import 'package:flutter_go_ship_pbl6/utils/services/storage_service.dart';
import '../../../domain/usecases/login_usecase.dart';

class LoginController extends BaseController {
  LoginController(this._loginUsecase, this._storageService);

  final LoginUsecase _loginUsecase;
  final StorageService _storageService;

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
      phoneTextEditingController.text = '0123456789';
      passwordTextEditingController.text = 'string';
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

  void onTapLogin(BuildContext context) {
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
          onSuccess: (account) {
            loginState.onSuccess();
            ignoringPointer.value = false;

            _storageService.setToken(account.accessToken ?? '');

            showOkAlertDialog(
                context: context,
                message:
                    'phone: ${account.phoneNumber}, role: ${account.role}');

            // N.toPatientList();
          },
          onError: (e) {
            if (e is DioError) {
              _showToastMessage(e.message);
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
