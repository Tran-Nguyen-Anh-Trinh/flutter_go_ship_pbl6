import 'package:flutter/cupertino.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/common.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../controller/welcome/welcome_controller.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorName.whiteFff,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 125,
                ),
                Center(
                  child: Assets.images.goShipMoto.image(width: 123, height: 105),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Go Ship',
                  style: AppTextStyle.w800s33(ColorName.primaryColor, letterSpacing: 0.38),
                ),
                Text(
                  'Chúng tôi là số 2, không ai là số 1',
                  style: AppTextStyle.w600s15(ColorName.black000, letterSpacing: 0.38),
                ),
                const SizedBox(
                  height: 192,
                ),
                CommonButton(
                  height: 44,
                  onPressed: N.toLoginPage,
                  fillColor: ColorName.primaryColor,
                  child: Text(
                    'Đăng nhập',
                    style: AppTextStyle.w400s16(ColorName.whiteFff),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                CommonButton(
                  height: 44,
                  onPressed: null,
                  fillColor: Colors.transparent,
                  borderColor: ColorName.primaryColor,
                  child: Text('Đăng ký', style: AppTextStyle.w400s16(ColorName.primaryColor)),
                ),
                const SizedBox(
                  height: 66,
                ),
                Text(
                  'Lái xe cùng Go Ship?',
                  style: AppTextStyle.w700s14(ColorName.redFf0, letterSpacing: 0.38),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  'Trở thành Đối tác của Go Ship.\nLàm chủ cuộc sống với chiếc xe của chính mình.',
                  style: AppTextStyle.w400s12(ColorName.gray838),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container( 
          margin: const EdgeInsets.only(bottom: 30),
          child: Text(
            'BCHQT - 0.0.1 (1)',
            style: AppTextStyle.w400s10(ColorName.gray828),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
