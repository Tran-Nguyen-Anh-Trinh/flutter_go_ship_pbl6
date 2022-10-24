import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/input_otp_widget.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 20),
                          CommonTextField(
                            formKey: controller.formKey,
                            type: FormFieldType.phone,
                            controller: controller.phoneTextEditingController,
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
                      onPressed: controller.onTapLogin,
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

// class MyWidget extends StatelessWidget {
//   const MyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     String res = '';
//     int curentIndex = 0;
//     RxList<String> listValue = ['', '', ''].obs;
//     bool check = false;
//     final textEditingController = TextEditingController();
//     return Column(
//       children: [
//         TextField(
//           maxLength: 3,
//           keyboardType: TextInputType.number,
//           controller: textEditingController,
//           onChanged: (value) {
//             for (int i = 0; i < listValue.length; i++) {
//               listValue[i] = '';
//             }
//             value.runes.toList().asMap().forEach((index, v) {
//               listValue[index] = String.fromCharCode(v);
//             });
//             curentIndex = value.runes.length;

//             check = value == '123';
//             print('check');
//             print(check);
//             // listValue.refresh();
//           },
//         ),
//         SizedBox(
//           width: Get.width,
//           height: 200,
//           child: ListView.builder(
//             padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
//             scrollDirection: Axis.horizontal,
//             shrinkWrap: true,
//             itemCount: 3,
//             itemBuilder: (context, index) {
//               return Row(
//                 children: [
//                   Obx(
//                     () => InputOTP(
//                       value: listValue[index],
//                       status: curentIndex == 3
//                           ? check
//                               ? 1
//                               : 3
//                           : (index == curentIndex)
//                               ? 1
//                               : listValue[index].isEmpty
//                                   ? 0
//                                   : 2,
//                     ),
//                   ),
//                   SizedBox(width: 12)
//                 ],
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
