import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/change_password_request.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/utils/extension/form_builder.dart';

import '../../../../base/presentation/base_widget.dart';
import '../../../authentication/data/providers/remote/request/phone_password_request.dart';
import '../../../authentication/domain/usecases/change_password_usecase.dart';

class ChangePasswordController extends BaseController {
  ChangePasswordController(this._changePasswordUsecase);
  final ChangePasswordUsecase _changePasswordUsecase;

  final oldPasswordTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmPasswordTextEditingController = TextEditingController();
  final formKey = GlobalKey<FormBuilderState>();
  final registerState = BaseState();

  String get _oldPassword => oldPasswordTextEditingController.text;
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
      oldPasswordTextEditingController.text = '123123';
      passwordTextEditingController.text = '123123';
      confirmPasswordTextEditingController.text = "123123";
    }
  }

  @override
  void onClose() {
    oldPasswordTextEditingController.dispose();
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
    isDisableButton.value =
        _oldPassword.isEmpty || _password.isEmpty || _confirmPassword.isEmpty;
  }

  Future<void> onTapChangePassword() async {
    try {
      final fbs = formKey.formBuilderState!;
      final oldPassword = FormFieldType.password.field(fbs);
      final passwordField = FormFieldType.password.field(fbs);
      final confirmPassword = FormFieldType.confirmPassword.field(fbs);
      [
        oldPassword,
        passwordField,
        confirmPassword,
      ].validateFormFields();
      if (_password != _confirmPassword) {
        _showToastMessage('Mật khẩu không trùng khớp');
        return;
      }

      if (registerState.isLoading) return;

      _changePasswordUsecase.execute(
        observer: Observer(
          onSubscribe: () {
            registerState.onLoading();
            ignoringPointer.value = true;
            hideErrorMessage();
          },
          onSuccess: (account) {
            registerState.onSuccess();
            ignoringPointer.value = false;
            showOkDialog(message: "Đổi mật khẩu thành công").then(
              (value) {
                if (value == OkCancelResult.ok) back();
              },
            );
          },
          onError: (e) async {
            debugPrint(e.toString());
            registerState.onSuccess();
            ignoringPointer.value = false;
            debugPrint(AppConfig.accountModel.accessToken);
          },
        ),
        input: ChangePasswordRequest(
          oldPassword: _oldPassword.trim(),
          newPassword: _password.trim(),
          confirmewPassword: _confirmPassword.trim(),
        ),
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
