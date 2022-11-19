import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/chat/presentation/view/view_media/item_view_page.dart';
import 'package:get/get.dart';

import '../../../../../base/presentation/base_widget.dart';

class ViewMediaController extends BaseController<Map<String, dynamic>> {
  late final List<String> urls;
  late final int? initPage;
  late final PageController pageController;
  @override
  void onInit() async {
    super.onInit();
    urls = input['urls'];
    initPage = input['initPage'];
    pageController = PageController(initialPage: initPage ?? 0);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  List<Widget> buildItemViewPage() {
    return urls.map((e) => ItemViewPage(url: e)).toList();
  }
}
