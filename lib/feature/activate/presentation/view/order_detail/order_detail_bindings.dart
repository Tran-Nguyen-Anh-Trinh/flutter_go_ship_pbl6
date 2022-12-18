import 'package:flutter_go_ship_pbl6/feature/activate/presentation/controller/order_detail/order_detail_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/customer_confirm_done_order_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_order_detail_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_shipper_with_id_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/receive_order_usecase.dart';
import 'package:get/get.dart';

class OrderDetailBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetOrderDetailUsecase(Get.find()));
    Get.lazyPut(() => ReceiveOrderUsecase(Get.find()));
    Get.lazyPut(() => GetShipperInfoWithIdUsecase(Get.find()));
    Get.lazyPut(() => CustomerConfirmDonerOrderUsecase(Get.find()));
    Get.put(OrderDetailController(
      Get.find(),
      Get.find(),
      Get.find(),
      Get.find(),
      Get.find(),
    ));
  }
}

class OrderDetailInput {
  String orderID;
  String notificationID;
  bool isRealtimeNotification;
  TypeOrderDetail typeOrderDetail;
  OrderDetailInput(
    this.orderID,
    this.notificationID, {
    required this.isRealtimeNotification,
    required this.typeOrderDetail,
  });
}

enum TypeOrderDetail {
  shipper,
  customerRating,
  customer,
  customerView,
}
