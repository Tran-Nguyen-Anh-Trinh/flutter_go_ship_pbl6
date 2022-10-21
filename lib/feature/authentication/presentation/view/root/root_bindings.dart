import 'package:get/get.dart';
import '../../controller/root/root_controller.dart';

class RootBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(RootController());
    }
}