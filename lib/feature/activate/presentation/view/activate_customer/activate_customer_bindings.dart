import 'package:flutter_go_ship_pbl6/feature/activate/presentation/controller/activate_customer/activate_customer_controller.dart';
import 'package:get/get.dart';

class ActivateCustomerBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(ActivateCustomerController());
    }
}