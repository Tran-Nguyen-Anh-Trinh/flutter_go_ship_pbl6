import 'package:flutter_go_ship_pbl6/feature/authentication/domain/usecases/login_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_customer_info.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_shipper_info_usecase.dart';
import 'package:get/get.dart';
import '../../controller/login/login_controller.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginUsecase(Get.find()));
    Get.lazyPut(() => GetShipperInfoUsecase(Get.find()));
    Get.lazyPut(() => GetCustomeInfoUsecase(Get.find()));
    Get.put(LoginController(
      Get.find(),
      Get.find(),
      Get.find(),
      Get.find(),
    ));
  }
}
