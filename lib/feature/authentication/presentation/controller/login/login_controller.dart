import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/utils/extension/form_builder.dart';
import 'package:get/get.dart';

import '../../../../../utils/config/app_navigation.dart';

class LoginController extends BaseController {
  // LoginController(this._loginWithEmailUseCase);

  // final LoginWithEmailUseCase _loginWithEmailUseCase;

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

      //   _loginWithEmailUseCase.execute(
      //     observer: Observer(
      //       onSubscribe: () {
      //         loginState.onLoading();
      //         ignoringPointer.value = true;
      //         hideErrorMessage();
      //       },
      //       onSuccess: (_) {
      //         loginState.onSuccess();
      //         N.toPatientList();
      //       },
      //       onError: (AppException e) {
      //         final fieldErrors = e.errorResponse?.errors;

      //         // Handle toast message
      //         if (fieldErrors == null || fieldErrors.isEmpty) {
      //           return _showToastMessage(e.message);
      //         }

      //         // Handle field message
      //         for (final fieldError in fieldErrors) {
      //           final fieldName = fieldError.field;
      //           if (fieldName == null) {
      //             return _showToastMessage(e.message);
      //           }

      //           final formFieldType = FormFieldType.values.byName(fieldName);
      //           switch (formFieldType) {
      //             case FormFieldType.email:
      //               emailField.invalidate(fieldError.message ?? S.current.messagesEmailError);
      //               break;
      //             case FormFieldType.password:
      //               passwordField.invalidate(fieldError.message ?? S.current.messagesPasswordError);
      //               break;
      //             default:
      //           }
      //           return _showToastMessage('');
      //         }
      //       },
      //     ),
      //     input: EmailPasswordRequest(
      //       _email.trim(),
      //       _password.trim(),
      //     ),
      //   );
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
