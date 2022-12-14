import 'package:flutter_go_ship_pbl6/feature/activate/presentation/controller/activate_customer/activate_customer_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/activate/presentation/controller/activate_shipper/activate_shipper_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/domain/usecases/update_token_device_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/confirm_done_order_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/delivery_order_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_orders_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_orders_with_status_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/home_customer/home_customer_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/home_shipper/home_shipper_controller.dart';
import 'package:get/get.dart';
import './tab_bar_controller.dart';

class TabBarBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeCustomerController(Get.find()));
    Get.lazyPut(() => GetOrdersUsecase(Get.find()));
    Get.lazyPut(() => GetOrderWithStatusUsecase(Get.find()));
    Get.lazyPut(() => ActivateCustomerController(Get.find(), Get.find()));
    Get.lazyPut(() => DeliveryOrderUsecase(Get.find()));
    Get.lazyPut(() => ConfirmDonerOrderUsecase(Get.find()));
    Get.lazyPut(() => HomeShipperController(Get.find(), Get.find(), Get.find()));
    Get.lazyPut(() => ActivateShipperController(Get.find(), Get.find()));
    Get.lazyPut(() => UpdateTokenDeviceUsecase(Get.find()));
    Get.put(TabBarController(Get.find(), Get.find()));
  }
}
