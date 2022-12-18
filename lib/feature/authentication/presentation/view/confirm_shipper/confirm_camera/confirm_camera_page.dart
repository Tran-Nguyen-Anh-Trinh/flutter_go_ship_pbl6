import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/camera_widget.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/controller/confirm_shipper/confirm_camera/confirm_camera_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/controller/confirm_shipper/confirm_shipper_controller.dart';

class ConfirmCameraPage extends BaseWidget<ConfirmCameraController> {
  const ConfirmCameraPage({Key? key}) : super(key: key);

  @override
  Widget onBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Obx(
          () => controller.cameras.isNotEmpty
              ? CameraWidget(
                  cameras: controller.cameras,
                  style: controller.typeCamera ?? TypeCamera.frontCCCD,
                  result: ((xFile) async {
                    controller.back();
                    if (controller.typeCamera == TypeCamera.frontCCCD) {
                      Get.find<ConfirmShipperController>().confirmFrontCCCD(xFile);
                    } else if (controller.typeCamera == TypeCamera.backsideCCCD) {
                      Get.find<ConfirmShipperController>().confirmBackSideCCCD(xFile);
                    } else {
                      Get.find<ConfirmShipperController>().confirmFace(xFile);
                    }
                  }),
                )
              : Container(
                  color: Colors.black,
                ),
        ),
      ),
    );
  }
}
