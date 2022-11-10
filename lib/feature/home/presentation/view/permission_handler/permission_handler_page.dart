import 'package:flutter_go_ship_pbl6/base/presentation/widgets/common.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/permission_handler/permission_handler_controller.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerPage extends GetView<PermissionHandlerController> {
  const PermissionHandlerPage({Key? key}) : super(key: key);

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
              const SizedBox(height: 125),
              Center(
                child: Assets.images.logoIcon.image(width: 123, height: 105),
              ),
              const SizedBox(height: 20),
              Text(
                'Go Ship',
                style: AppTextStyle.w800s33(ColorName.primaryColor, letterSpacing: 0.38),
              ),
              Text(
                'Cho phép Go Ship truy cập vào thông tin vị trí của thiết bị này?',
                style: AppTextStyle.w500s20(ColorName.black000),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Go Ship yêu cầu thông tin vị trí của thiết bị để sử dụng một số chức năng chính của ứng dụng.',
                  style: AppTextStyle.w400s13(ColorName.gray828),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Assets.images.permissionIcon1.image(width: 120, height: 120),
                  Assets.images.permissionIcon2.image(width: 120, height: 120),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        margin: const EdgeInsets.only(bottom: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Điều này là bắt buộc để sử dụng Go Ship*',
              style: AppTextStyle.w500s10(ColorName.primaryColor),
            ),
            const SizedBox(height: 5),
            CommonButton(
              height: 44,
              onPressed: () {
                Permission.locationWhenInUse.request().then((ignored) {
                  if (ignored.isPermanentlyDenied) {
                    openAppSettings();
                  }
                  controller.fetchPermissionStatus();
                });
              },
              fillColor: ColorName.primaryColor,
              child: Text(
                'Đồng ý',
                style: AppTextStyle.w400s16(ColorName.whiteFff),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
