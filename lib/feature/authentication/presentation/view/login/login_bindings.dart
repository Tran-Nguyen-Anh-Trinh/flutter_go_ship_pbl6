import 'package:get/get.dart';
import '../../controller/login/login_controller.dart';

class LoginBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(LoginController());
    }
}