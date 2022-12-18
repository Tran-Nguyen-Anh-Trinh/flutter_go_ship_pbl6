import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/notification/notification_controller.dart';
import 'package:get/get.dart';

class NotificationBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(NotificationController());
    }
}