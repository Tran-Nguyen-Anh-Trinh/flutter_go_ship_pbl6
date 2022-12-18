import 'package:flutter_go_ship_pbl6/feature/activate/presentation/controller/activate_shipper/activate_shipper_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_orders_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_orders_with_status_usecase.dart';
import 'package:get/get.dart';

class ActivateShipperBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetOrdersUsecase(Get.find()));
    Get.lazyPut(() => GetOrderWithStatusUsecase(Get.find()));
    Get.put(ActivateShipperController(Get.find(), Get.find()));
  }
}