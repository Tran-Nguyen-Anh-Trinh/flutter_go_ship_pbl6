import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/camera_widget.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/common.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/controller/confirm_shipper/confirm_shipper_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/view/confirm_shipper/confirm_shipper_page.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:scan/scan.dart';

extension ConfirmShipperPage2 on ConfirmShipperPage {
  Widget confirmShipper2(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: controller.hideKeyboard,
              child: IgnorePointer(
                ignoring: controller.ignoringPointer.value,
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: MediaQuery.of(context).viewPadding.top + 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "2/3",
                                    style: AppTextStyle.w600s20(ColorName.primaryColor),
                                  ),
                                  const SizedBox(width: 20)
                                ],
                              ),
                              const SizedBox(height: 90),
                              Assets.images.confirmShipperPage2Icon.image(width: 50),
                              const SizedBox(height: 10),
                              Text(
                                "Chụp giấy tờ tùy thân",
                                style: AppTextStyle.w600s20(ColorName.black000),
                              ),
                              const SizedBox(height: 40),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 30),
                                  Assets.images.confirmShipperPage2CccdIcon.image(width: 65),
                                  const SizedBox(width: 20),
                                  Text(
                                    "Giấy CCCD bản gốc và còn hiệu lực",
                                    style: AppTextStyle.w400s12(ColorName.black000),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 30),
                                  Assets.images.confirmShipperPage2CccdWithScanIcon.image(width: 65),
                                  const SizedBox(width: 20),
                                  Text(
                                    "Giữ giấy tờ nằm thẳng trong khung hình",
                                    style: AppTextStyle.w400s12(ColorName.black000),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 30),
                                  Assets.images.confirmShipperPage2CccdBlurIcon.image(width: 65),
                                  const SizedBox(width: 20),
                                  Text(
                                    "Tránh chụp tối, mờ, lóe sáng",
                                    style: AppTextStyle.w400s12(ColorName.black000),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      CommonBottomButton(
                        text: 'Bắt đầu',
                        onPressed: () => controller.identifyCheck(TypeCamera.frontCCCD),
                        pressedOpacity: 0.4,
                        fillColor: ColorName.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
