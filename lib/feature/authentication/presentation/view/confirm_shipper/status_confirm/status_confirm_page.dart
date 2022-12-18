import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/common.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import '../../../controller/confirm_shipper/status_confirm/status_confirm_controller.dart';

class StatusConfirmPage extends BaseWidget<StatusConfirmController> {
  const StatusConfirmPage({Key? key}) : super(key: key);

  @override
  Widget onBuild(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => (controller.isDeny.value)
            ? SizedBox(
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
                            Assets.images.denyIcon.image(width: 50),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              child: Text(
                                "Yêu cầu đăng ký của bạn đã bị từ chối",
                                textAlign: TextAlign.center,
                                style: AppTextStyle.w600s20(ColorName.black000),
                              ),
                            ),
                            const SizedBox(height: 40),
                            Assets.images.goShipMoto.image(width: 150),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              child: Text(
                                "Xin lỗi nhưng một số thông tin bạn cung cấp chưa có tính xác thực bạn có thể thực hiện lại việc xác thực",
                                textAlign: TextAlign.center,
                                style: AppTextStyle.w400s16(ColorName.black000),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CommonBottomButton(
                      text: 'Xác thực thông tin',
                      onPressed: () => controller.toConfirm(),
                      pressedOpacity: 0.4,
                      fillColor: ColorName.primaryColor,
                    ),
                  ],
                ))
            : SizedBox(
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
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              child: Text(
                                "Yêu cầu xác thực đang trong quá trình xử lý",
                                textAlign: TextAlign.center,
                                style: AppTextStyle.w600s20(ColorName.black000),
                              ),
                            ),
                            const SizedBox(height: 40),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              child: Text(
                                "Cảm ơn bạn đã tin tưởng để trở thành đối tác với Go Ship",
                                textAlign: TextAlign.center,
                                style: AppTextStyle.w600s16(ColorName.black000),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Assets.images.goShipMoto.image(width: 150),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              child: Text(
                                "Chúng tôi sẽ sớm xác nhận và phản hồi đơn đăng ký của bạn.Hẹn sớm gặp lại bạn vào thời gian gần nhất",
                                textAlign: TextAlign.center,
                                style: AppTextStyle.w400s16(ColorName.black000),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CommonBottomButton(
                      text: 'Quay lại màn hình chính',
                      onPressed: () => controller.toLandingPage(),
                      pressedOpacity: 0.4,
                      fillColor: ColorName.primaryColor,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
