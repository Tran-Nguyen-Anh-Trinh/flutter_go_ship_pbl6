import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/home_customer/home_customer_controller.dart';
import 'package:get/get.dart';

class HomeCustomerBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(HomeCustomerController());
    }
}