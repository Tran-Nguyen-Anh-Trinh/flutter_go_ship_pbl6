import 'package:get/get.dart';

import '../../controller/chat_detail/chat_detail_controller.dart';

class ChatDetailBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ChatDetailController(Get.find(), Get.find()));
  }
}
