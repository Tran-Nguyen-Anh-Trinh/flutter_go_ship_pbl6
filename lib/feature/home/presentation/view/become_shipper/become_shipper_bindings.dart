import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/become_shipper/become_shipper_controller.dart';
import 'package:get/get.dart';

class BecomeShipperBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(BecomeShipperController());
    }
}