import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/common.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/view/confirm_shipper/confirm_shipper_page.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';

extension ConfirmShipperPage4 on ConfirmShipperPage {
  Widget confirmShipper4(BuildContext context) {
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
                              const SizedBox(height: 190),
                              Assets.images.confirmShipperSuccessIcon.image(width: 50),
                              const SizedBox(height: 10),
                              Text(
                                "Xác thực thông tin cá nhân",
                                style: AppTextStyle.w600s20(ColorName.black000),
                              ),
                              const SizedBox(height: 40),
                              Assets.images.logoIcon.image(width: 150),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  "Sau khi thực hiện xác thực và được xác nhận từ phía GoShip bạn có thể chính thức trở thành một thành viên người vận chuyển của chúng tôi",
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.w400s16(ColorName.black000),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CommonBottomButton(
                        text: 'Xác nhận',
                        onPressed: () => controller.confirmShipper(),
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
