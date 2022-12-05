import 'package:flutter_go_ship_pbl6/feature/activate/presentation/controller/activate_customer/activate_customer_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/activate/presentation/controller/activate_shipper/activate_customer_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/domain/usecases/update_token_device_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/home_customer/home_customer_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/home_shipper/home_shipper_controller.dart';
import 'package:get/get.dart';
import './tab_bar_controller.dart';

class TabBarBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeCustomerController());
    Get.lazyPut(ActivateCustomerController.new);
    Get.lazyPut(() => HomeShipperController(Get.find()));
    Get.lazyPut(ActivateShipperController.new);
    Get.lazyPut(() => UpdateTokenDeviceUsecase(Get.find()));
    Get.put(TabBarController(Get.find()));
  }
}
