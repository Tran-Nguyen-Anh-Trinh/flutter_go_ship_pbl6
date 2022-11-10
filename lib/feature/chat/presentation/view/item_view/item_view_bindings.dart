import 'package:get/get.dart';
import '../../controller/item_view/item_view_controller.dart';

class ItemViewBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(ItemViewController());
    }
}