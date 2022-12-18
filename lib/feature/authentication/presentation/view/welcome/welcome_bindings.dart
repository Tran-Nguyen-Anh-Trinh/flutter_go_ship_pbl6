import 'package:get/get.dart';
import '../../controller/welcome/welcome_controller.dart';

class WelcomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(WelcomeController());
  }
}
