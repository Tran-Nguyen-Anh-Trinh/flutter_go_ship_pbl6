import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/extension/form_builder.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends BaseController {
  final phoneTextEditingController = TextEditingController();

  final formKey = GlobalKey<FormBuilderState>();
  final forgotPassState = BaseState();

  final ignoringPointer = false.obs;
  final isDisableButton = true.obs;
  final errorMessage = ''.obs;

  String get _phone => phoneTextEditingController.text;

  @override
  void onClose() {
    phoneTextEditingController.dispose();
    super.onClose();
  }

  void hideErrorMessage() {
    errorMessage.value = '';
  }

  void updateLoginButtonState() {
    isDisableButton.value = _phone.isEmpty;
  }

  void onTapForgotPassword() {
    try {
      final fbs = formKey.formBuilderState!;
      final phoneField = FormFieldType.phone.field(fbs);
      [
        phoneField,
      ].validateFormFields();

      N.toForgotPasswordOtpPage();
      // if (forgotPassState.isLoading) return;

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
    forgotPassState.onError(message);
    ignoringPointer.value = false;
    errorMessage.value = message;
  }

  void resetDataTextField() {
    hideErrorMessage();
  }
}
