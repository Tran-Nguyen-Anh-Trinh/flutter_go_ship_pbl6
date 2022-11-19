import 'package:get/get.dart';
import '../../controller/view_media/view_media_controller.dart';

class ViewMediaBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(ViewMediaController());
    }
}