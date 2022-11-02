import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/controller/add_address/add_address_controller.dart';
import 'package:get/get.dart';

class AddAddressBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(AddAddressController());
    }
}