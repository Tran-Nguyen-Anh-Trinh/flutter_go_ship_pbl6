import 'package:flutter/cupertino.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../base/presentation/base_app_bar.dart';
import '../../../../../base/presentation/widgets/common.dart';
import '../../../../../base/presentation/widgets/input_otp_widget.dart';
import '../../controller/forgot_password/forgot_password_controller.dart';

class ForgotPasswordOtpPage extends GetView<ForgotPasswordController> {
  const ForgotPasswordOtpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BaseAppBar(
        title: const Text('Quên mật khẩu'),
      ),
      backgroundColor: Colors.white,
      body: Obx(
        () => IgnorePointer(
          ignoring: controller.ignoringPointer.value,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 4, left: 16, right: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 64),
                    Assets.images.phoneIcon.image(scale: 3),
                    const SizedBox(height: 20),
                    Text(
                      'Nhập mã OTP',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.w400s12(ColorName.gray4f4),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Chúng tôi đã gửi tin nhắn SMS có mã kích hoạt đến số điện thoại của bạn',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.w400s12(ColorName.gray838),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '+84 343440509',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.w400s12(ColorName.black000),
                    ),
                    const SizedBox(height: 37),
                  ],
                ),
              ),
              InputOTPWidget(
                otpCode: 123456,
                callback: () {
                  print('Thành công');
                },
              ),
              const SizedBox(height: 47),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                child: Text(
                  'Gửi lại mã (10s)',
                  style: AppTextStyle.w400s12(ColorName.primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
