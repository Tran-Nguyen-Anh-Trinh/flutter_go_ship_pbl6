import 'package:flutter/cupertino.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_app_bar.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/input_otp_widget.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/controller/register_customer/confirm_register_customer/confirm_register_customer_controller.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ConfirmRegisterCustomerPage extends GetView<ConfirmRegisterCustomerController> {
  const ConfirmRegisterCustomerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BaseAppBar(
        title: const Text('Xác nhận đăng ký'),
      ),
      backgroundColor: Colors.white,
      body: Column(
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
                  '+84 38 4933 379',
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
    );
  }
}
