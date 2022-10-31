import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/controller/register_customer/confirm_register_customer/confirm_register_customer_controller.dart';
import 'package:get/get.dart';

class ConfirmRegisterCustomerBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(ConfirmRegisterCustomerController());
    }
}