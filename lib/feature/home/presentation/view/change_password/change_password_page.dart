import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_app_bar.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/common.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/controller/register_customer/register_customer_controller.dart';
import 'package:flutter_go_ship_pbl6/utils/extension/form_builder.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';

import '../../change_password/change_password_controller.dart';

class ChangePasswordPage extends BaseWidget<ChangePasswordController> {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget onBuild(BuildContext context) {
    return GestureDetector(
      onTap: controller.hideKeyboard,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BaseAppBar(
          title: const Text('Đổi mật khẩu'),
        ),
        backgroundColor: Colors.white,
        body: Obx(
          () => IgnorePointer(
            ignoring: controller.ignoringPointer.value,
            child: SizedBox(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 16, right: 16),
                    child: FormBuilder(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 20),
                          CommonTextField(
                            formKey: controller.formKey,
                            type: FormFieldType.password,
                            controller:
                                controller.oldPasswordTextEditingController,
                            obscureText: controller.isShowPassword.value,
                            suffixIcon: controller.isShowPassword.value
                                ? Assets.images.showPassIcon.image(scale: 3)
                                : Assets.images.hidePassIcon.image(scale: 3),
                            onPressedSuffixIcon: controller.onTapShowPassword,
                            onTap: controller.hideErrorMessage,
                            onChanged: (_) {
                              controller.updateRegisterButtonState();
                            },
                          ),
                          const SizedBox(height: 2),
                          CommonTextField(
                            formKey: controller.formKey,
                            type: FormFieldType.password,
                            controller:
                                controller.passwordTextEditingController,
                            obscureText: controller.isShowPassword.value,
                            suffixIcon: controller.isShowPassword.value
                                ? Assets.images.showPassIcon.image(scale: 3)
                                : Assets.images.hidePassIcon.image(scale: 3),
                            onPressedSuffixIcon: controller.onTapShowPassword,
                            onTap: controller.hideErrorMessage,
                            onChanged: (_) {
                              controller.updateRegisterButtonState();
                            },
                          ),
                          const SizedBox(height: 2),
                          CommonTextField(
                            formKey: controller.formKey,
                            type: FormFieldType.confirmPassword,
                            controller:
                                controller.confirmPasswordTextEditingController,
                            textInputAction: TextInputAction.done,
                            obscureText: controller.isShowConfirmPassword.value,
                            suffixIcon: controller.isShowConfirmPassword.value
                                ? Assets.images.showPassIcon.image(scale: 3)
                                : Assets.images.hidePassIcon.image(scale: 3),
                            onPressedSuffixIcon:
                                controller.onTapShowConfirmPassword,
                            onTap: controller.hideErrorMessage,
                            onChanged: (_) {
                              controller.updateRegisterButtonState();
                            },
                            onSubmitted: (_) {
                              controller.onTapChangePassword();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Obx(
                    () =>
                        CommonBottomError(text: controller.errorMessage.value),
                  ),
                  Obx(
                    () => CommonBottomButton(
                      text: 'Xác nhận',
                      onPressed: controller.onTapChangePassword,
                      pressedOpacity:
                          controller.isDisableButton.value ? 1 : 0.4,
                      fillColor: controller.isDisableButton.value
                          ? ColorName.gray838
                          : ColorName.primaryColor,
                      state: controller.registerState,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
