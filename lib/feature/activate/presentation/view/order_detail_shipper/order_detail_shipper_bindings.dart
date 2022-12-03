import 'package:flutter_go_ship_pbl6/feature/activate/presentation/controller/order_detail_shipper/order_detail_shipper_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_order_detail_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/receive_order_usecase.dart';
import 'package:get/get.dart';

class OrderDetailShipperBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetOrderDetailUsecase(Get.find()));
    Get.lazyPut(() => ReceiveOrderUsecase(Get.find()));
    Get.put(OrderDetailShipperController(Get.find(), Get.find()));
  }
}
