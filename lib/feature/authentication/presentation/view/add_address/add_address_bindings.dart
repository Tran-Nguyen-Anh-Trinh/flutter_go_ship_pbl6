import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/controller/add_address/add_address_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/update_customer_info_usecase.dart';
import 'package:get/get.dart';

class AddAddressBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateCustomerInfoUsecase(Get.find()));
    Get.put(AddAddressController(Get.find()));
  }
}
