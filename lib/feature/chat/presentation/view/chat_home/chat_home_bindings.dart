import 'package:get/get.dart';
import '../../controller/home_chat/chat_home_controller.dart';

class ChatHomeBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(ChatHomeController(Get.find()));
    }
}