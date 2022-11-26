import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/setting/setting_controller.dart';
import 'package:get/get.dart';

class SettingBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SettingController(Get.find()));
  }
}
