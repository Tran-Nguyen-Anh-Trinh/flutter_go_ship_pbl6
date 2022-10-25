import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/controller/register_customer/register_customer_controller.dart';
import 'package:get/get.dart';


class RegisterCustomerBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(RegisterCustomerController());
    }
}