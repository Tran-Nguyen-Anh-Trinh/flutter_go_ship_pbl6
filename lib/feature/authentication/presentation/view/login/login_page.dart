import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../base/presentation/base_app_bar.dart';
import '../../../../../base/presentation/widgets/common.dart';
import '../../../../../utils/config/app_text_style.dart';
import '../../../../../utils/extension/form_builder.dart';
import '../../../../../utils/gen/colors.gen.dart';
import '../../controller/login/login_controller.dart';

class LoginPage extends GetView<LoginController> {
    
    const LoginPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return GestureDetector(
      onTap: controller.hideKeyboard,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BaseAppBar(
          title: const Text('Đăng nhập'),
        ),
        body: Obx(
          () => IgnorePointer(
            ignoring: controller.ignoringPointer.value,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 16, right: 16),
                    child: FormBuilder(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          CommonTextField(
                            formKey: controller.formKey,
                            type: FormFieldType.phone,
                            controller: controller.emailTextEditingController,
                            onTap: controller.hideErrorMessage,
                            onChanged: (_) {
                              controller.updateLoginButtonState();
                            },
                          ),
                          CommonTextField(
                            formKey: controller.formKey,
                            type: FormFieldType.password,
                            controller: controller.passwordTextEditingController,
                            textInputAction: TextInputAction.done,
                            obscureText: controller.isHidePassword.value,
                            suffixIcon: Text(
                              'Quên mật khẩu',
                              style: AppTextStyle.w400s9(ColorName.blue007),
                            ),
                            onPressedSuffixIcon: controller.onTapResetPassword,
                            onTap: controller.hideErrorMessage,
                            onChanged: (_) {
                              controller.updateLoginButtonState();
                            },
                            onSubmitted: (_) {
                              controller.onTapLogin();
                            },
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Obx(
                    () => CommonBottomError(text: controller.errorMessage.value),
                  ),
                  Obx(
                    () => CommonBottomButton(
                      text: S.current.login,
                      onPressed: controller.onTapLogin,
                      pressedOpacity: controller.isDisableButton.value ? 1 : 0.4,
                      fillColor: controller.isDisableButton.value ? ColorName.gray838 : ColorName.green459,
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