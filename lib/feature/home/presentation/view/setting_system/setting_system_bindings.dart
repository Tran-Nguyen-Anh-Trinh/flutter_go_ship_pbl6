import 'package:get/get.dart';
import '../../system_system/setting_system_controller.dart';

class SettingSystemBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SettingSystemController(Get.find(), Get.find()));
  }
}
