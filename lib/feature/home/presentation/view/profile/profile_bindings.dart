import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/update_customer_info_usecase.dart';
import 'package:get/get.dart';
import '../../controller/profile/profile_controller.dart';

class ProfileBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateCustomerInfoUsecase(Get.find()));
    Get.put(ProfileController(Get.find(), Get.find()));
  }
}
