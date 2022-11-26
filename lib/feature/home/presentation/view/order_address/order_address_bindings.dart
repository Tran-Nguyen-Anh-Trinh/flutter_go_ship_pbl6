import 'package:get/get.dart';
import '../../controller/order_address/order_address_controller.dart';

class OrderAddressBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(OrderAddressController());
    }
}