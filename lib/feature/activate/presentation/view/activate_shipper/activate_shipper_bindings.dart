import 'package:flutter_go_ship_pbl6/feature/activate/presentation/controller/activate_shipper/activate_customer_controller.dart';
import 'package:get/get.dart';

class ActivateShipperBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ActivateShipperController());
  }
}
