import 'package:flutter_go_ship_pbl6/feature/authentication/domain/usecases/confirm_shipper_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/domain/usecases/token_refresh_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/controller/confirm_shipper/confirm_shipper_controller.dart';
import 'package:get/get.dart';

class ConfirmShipperBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConfirmShipperUsecase(Get.find()));
    Get.lazyPut(() => RefreshTokenUsecase(Get.find()));
    Get.put(ConfirmShipperController(Get.find(), Get.find(), Get.find(), Get.find()));
  }
}
