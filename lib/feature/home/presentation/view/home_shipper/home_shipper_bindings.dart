import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/home_shipper/home_shipper_controller.dart';
import 'package:get/get.dart';

class HomeShipperBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(HomeShipperController(Get.find()));
    }
}