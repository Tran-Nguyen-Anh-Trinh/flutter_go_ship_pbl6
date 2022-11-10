import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/permission_handler/permission_handler_controller.dart';
import 'package:get/get.dart';

class PermissionHandlerBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(PermissionHandlerController());
    }
}