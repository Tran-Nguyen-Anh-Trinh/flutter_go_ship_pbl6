import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/confirm_done_order_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/delivery_order_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/home_shipper/home_shipper_controller.dart';
import 'package:get/get.dart';

class HomeShipperBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DeliveryOrderUsecase(Get.find()));
    Get.lazyPut(() => ConfirmDonerOrderUsecase(Get.find()));
    Get.put(HomeShipperController(Get.find(), Get.find(), Get.find()));
  }
}
