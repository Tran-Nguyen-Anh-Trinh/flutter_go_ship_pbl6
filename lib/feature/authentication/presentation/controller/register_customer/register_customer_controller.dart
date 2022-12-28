import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/phone_password_request.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/register_request%20.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/domain/usecases/check_user_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/domain/usecases/login_usecase.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/extension/form_builder.dart';

class RegisterCustomerController extends BaseController<int> {
  RegisterCustomerController(this._checkUserUsecase);

  final CheckUserUsecase _checkUserUsecase;

  final phoneTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmPasswordTextEditingController = TextEditingController();
  final formKey = GlobalKey<FormBuilderState>();
  final registerState = BaseState();

  String get _phone => phoneTextEditingController.text;
  String get _password => passwordTextEditingController.text;
  String get _confirmPassword => confirmPasswordTextEditingController.text;

  final isDisableButton = true.obs;
  final ignoringPointer = false.obs;
  final errorMessage = ''.obs;
  final isShowPassword = true.obs;
  final isShowConfirmPassword = true.obs;

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      phoneTextEditingController.text = '0384933379';
      passwordTextEditingController.text = '123123';
      confirmPasswordTextEditingController.text = "123123";
    }
  }

  @override
  void onClose() {
    phoneTextEditingController.dispose();
    passwordTextEditingController.dispose();
    confirmPasswordTextEditingController.dispose();
    super.onClose();
  }

  void onTapShowPassword() {
    isShowPassword.value = !isShowPassword.value;
  }

  void onTapShowConfirmPassword() {
    isShowConfirmPassword.value = !isShowConfirmPassword.value;
  }

  void hideErrorMessage() {
    errorMessage.value = '';
  }

  void updateRegisterButtonState() {
    isDisableButton.value = _phone.isEmpty || _password.isEmpty || _confirmPassword.isEmpty;
  }

  Future<void> onTapRegister() async {
    try {
      final fbs = formKey.formBuilderState!;
      final phoneField = FormFieldType.phone.field(fbs);
      final passwordField = FormFieldType.password.field(fbs);
      final confirmPassword = FormFieldType.confirmPassword.field(fbs);
      [
        phoneField,
        passwordField,
        confirmPassword,
      ].validateFormFields();
      if (_password != _confirmPassword) {
        _showToastMessage('Mật khẩu không trùng khớp');
        return;
      }

      if (registerState.isLoading) return;
      print(_phone.trim());
      _checkUserUsecase.execute(
        observer: Observer(
          onSubscribe: () {
            registerState.onLoading();
            ignoringPointer.value = true;
            hideErrorMessage();
          },
          onSuccess: (account) {
            registerState.onSuccess();
            ignoringPointer.value = false;
            _showToastMessage("Số điện thoại này đã tồn tại.");
          },
          onError: (e) async {
            if (kDebugMode) {
              print(e.response?.data['detail'].toString());
              print(e);
            }
            String phone = _phone.trim();
            if (phone.substring(0, 1) == "0") {
              phone = "+84${phone.substring(1)}";
            }
            print(phone);
            if (Platform.isIOS) {
              N.toConfirmRegisterCustomer(
                registerRequest: RegisterRequest(
                  _phone.trim(),
                  _password.trim(),
                  input,
                  verificationId: 'testIOS',
                ),
              );
              ignoringPointer.value = false;
              registerState.onSuccess();
              return;
            }
            await FirebaseAuth.instance.verifyPhoneNumber(
              phoneNumber: phone,
              verificationCompleted: (PhoneAuthCredential credential) {},
              verificationFailed: (FirebaseAuthException e) {
                registerState.onSuccess();
                ignoringPointer.value = false;
                _showToastMessage("Không thể xác thực số điện thoại này.");
              },
              timeout: const Duration(seconds: 20),
              codeSent: (String verificationId, int? resendToken) {
                N.toConfirmRegisterCustomer(
                  registerRequest: RegisterRequest(
                    _phone.trim(),
                    _password.trim(),
                    input,
                    verificationId: verificationId,
                  ),
                );
                ignoringPointer.value = false;
                registerState.onSuccess();
              },
              codeAutoRetrievalTimeout: (String verificationId) {},
            );
          },
        ),
        input: _phone.trim(),
      );
    } on Exception catch (e) {
      isDisableButton.value = true;
    }
  }

  void _showToastMessage(String message) {
    registerState.onError(message);
    ignoringPointer.value = false;
    errorMessage.value = message;
  }

  void resetDataTextField() {
    hideErrorMessage();
    passwordTextEditingController.text = '';
  }
}
