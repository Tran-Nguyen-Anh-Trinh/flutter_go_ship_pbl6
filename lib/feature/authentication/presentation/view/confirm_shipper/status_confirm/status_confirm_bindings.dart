import 'package:get/get.dart';
import '../../../controller/confirm_shipper/status_confirm/status_confirm_controller.dart';

class StatusConfirmBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(StatusConfirmController(Get.find()));
    }
}