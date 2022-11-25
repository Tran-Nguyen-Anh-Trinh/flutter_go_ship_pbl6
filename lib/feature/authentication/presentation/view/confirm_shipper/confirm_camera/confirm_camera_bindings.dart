import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/controller/confirm_shipper/confirm_camera/confirm_camera_controller.dart';
import 'package:get/get.dart';

class ConfirmCameraBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(ConfirmCameraController());
    }
}