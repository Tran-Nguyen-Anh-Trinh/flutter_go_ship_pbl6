import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/search/search_controller.dart';
import 'package:get/get.dart';

class SearchBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(SearchController());
    }
}