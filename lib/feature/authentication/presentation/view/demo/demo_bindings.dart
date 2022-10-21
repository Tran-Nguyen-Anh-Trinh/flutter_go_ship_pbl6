import 'package:get/get.dart';

import '../../../domain/usecases/get_user_data_usecase.dart';
import '../../controller/demo/demo_controller.dart';

class DemoBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetDataUserUsecase(Get.find()));

    Get.put(DemoController(Get.find()));
  }
}
