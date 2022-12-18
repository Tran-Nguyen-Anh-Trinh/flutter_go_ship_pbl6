import 'package:flutter_go_ship_pbl6/feature/authentication/domain/usecases/token_refresh_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_customer_info.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_shipper_info_usecase.dart';
import 'package:get/get.dart';
import '../../controller/root/root_controller.dart';

class RootBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetShipperInfoUsecase(Get.find()));
    Get.lazyPut(() => RefreshTokenUsecase(Get.find()));
    Get.lazyPut(() => GetCustomeInfoUsecase(Get.find()));
    Get.put(RootController(Get.find(), Get.find(), Get.find(), Get.find()));
  }
}
