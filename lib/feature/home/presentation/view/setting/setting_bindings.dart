import 'package:flutter_go_ship_pbl6/feature/authentication/domain/usecases/update_token_device_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_customer_info.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_shipper_info_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/update_customer_info_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/setting/setting_controller.dart';
import 'package:get/get.dart';

class SettingBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetCustomeInfoUsecase(Get.find()));
    Get.lazyPut(() => GetShipperInfoUsecase(Get.find()));
    Get.lazyPut(() => UpdateCustomerInfoUsecase(Get.find()));
    Get.lazyPut(() => UpdateTokenDeviceUsecase(Get.find()));
    Get.put(SettingController(
      Get.find(),
      Get.find(),
      Get.find(),
      Get.find(),
      Get.find(),
    ));
  }
}
