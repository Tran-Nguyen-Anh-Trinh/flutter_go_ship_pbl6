import 'package:flutter_go_ship_pbl6/base/presentation/widgets/common.dart';
import 'package:flutter_go_ship_pbl6/feature/chat/presentation/view/view_media/item_view_page.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../controller/view_media/view_media_controller.dart';

class ViewMediaPage extends GetView<ViewMediaController> {
  const ViewMediaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.black000,
      body: Stack(
        children: [
          SizedBox(
            width: Get.width,
            height: Get.height,
            child: PageView.builder(
              controller: controller.pageController,
              scrollDirection: Axis.horizontal,
              itemCount: controller.urls.length,
              itemBuilder: (BuildContext context, int index) {
                return ItemViewPage(url: controller.urls[index]);
              },
            ),
          ),
          SafeArea(
            child: Container(
              color: Colors.transparent,
              child: const CommonBackButton(),
            ),
          )
        ],
      ),
    );
  }
}
