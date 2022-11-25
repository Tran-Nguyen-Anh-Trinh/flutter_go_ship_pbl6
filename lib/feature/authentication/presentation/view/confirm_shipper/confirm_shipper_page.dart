import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/common.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/controller/confirm_shipper/confirm_shipper_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/view/confirm_shipper/confirm_page/page1.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/view/confirm_shipper/confirm_page/page2.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/view/confirm_shipper/confirm_page/page3.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/view/confirm_shipper/confirm_page/page4.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/view/confirm_shipper/confirm_page/page5.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';

class ConfirmShipperPage extends BaseWidget<ConfirmShipperController> {
  const ConfirmShipperPage({Key? key}) : super(key: key);

  @override
  Widget onBuild(BuildContext context) {
    return GestureDetector(
      onTap: controller.hideKeyboard,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Obx(
          () => Stack(
            children: [
              if (controller.currentPageIndex.value == 1) confirmShipper1(context),
              if (controller.currentPageIndex.value == 2) confirmShipper2(context),
              if (controller.currentPageIndex.value == 3) confirmShipper3(context),
              if (controller.currentPageIndex.value == 4) confirmShipper4(context),
              if (controller.currentPageIndex.value == 5) confirmShipper5(context),
              if (controller.stateConfirm.value)
                Positioned.fill(
                  child: Container(
                    color: ColorName.black000.withOpacity(0.6),
                    child: const LoadingWidget(
                      color: ColorName.whiteFff,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
