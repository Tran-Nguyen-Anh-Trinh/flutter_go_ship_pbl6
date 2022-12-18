import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import '../../../../../base/presentation/base_app_bar.dart';
import '../../../../../base/presentation/widgets/common.dart';
import '../../../../../utils/config/app_text_style.dart';
import '../../../../../utils/extension/form_builder.dart';
import '../../../../../utils/gen/colors.gen.dart';
import '../../controller/login/login_controller.dart';

class LoginPage extends BaseWidget<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget onBuild(BuildContext context) {
    return GestureDetector(
      onTap: controller.hideKeyboard,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BaseAppBar(
          title: const Text('Đăng nhập'),
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
                            type: FormFieldType.phone,
                            maxLength: 13,
                            controller: controller.phoneTextEditingController,
                            onTap: controller.hideErrorMessage,
                            onChanged: (_) {
                              controller.updateLoginButtonState();
                            },
                          ),
                          const SizedBox(height: 2),
                          CommonTextField(
                            formKey: controller.formKey,
                            type: FormFieldType.password,
                            controller: controller.passwordTextEditingController,
                            textInputAction: TextInputAction.done,
                            obscureText: controller.isShowPassword.value,
                            suffixIcon: controller.isShowPassword.value
                                ? Assets.images.showPassIcon.image(scale: 3)
                                : Assets.images.hidePassIcon.image(scale: 3),
                            onPressedSuffixIcon: controller.onTapShowPassword,
                            onTap: controller.hideErrorMessage,
                            onChanged: (_) {
                              controller.updateLoginButtonState();
                            },
                            onSubmitted: (_) {
                              controller.onTapLogin();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: N.toForgotPasswordPage,
                    child: Text(
                      'Quên mật khẩu?',
                      style: AppTextStyle.w400s12(ColorName.gray838),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () => CommonBottomError(text: controller.errorMessage.value),
                  ),
                  Obx(
                    () => CommonBottomButton(
                      text: 'Đăng nhập',
                      onPressed: () => controller.onTapLogin(),
                      pressedOpacity: controller.isDisableButton.value ? 1 : 0.4,
                      fillColor: controller.isDisableButton.value ? ColorName.gray838 : ColorName.primaryColor,
                      state: controller.loginState,
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
