import 'package:flutter_go_ship_pbl6/base/presentation/base_app_bar.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/feature/activate/presentation/controller/activate_shipper/activate_shipper_controller.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/common.dart';
import 'package:flutter_go_ship_pbl6/feature/activate/presentation/view/activate_customer/widgets/widget.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';

class ActivateShipperPage extends BaseWidget<ActivateShipperController> {
  const ActivateShipperPage({Key? key}) : super(key: key);

  @override
  Widget onBuild(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: const Text('Hoạt động'),
        leading: null,
      ),
      backgroundColor: ColorName.whiteFff,
      body: Obx(
        () {
          print(controller.currentIndexPageView.value);
          return Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                  controller: controller.menuScrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.menu.length,
                  itemBuilder: (context, index) {
                    return MenuActive(
                      title: controller.menu[index].title,
                      isActive: controller.currentIndexPageView.value == index,
                      onPressed: () => controller.selectPage(index),
                    );
                  },
                ),
              ),
              Container(
                height: 8,
                color: ColorName.grayF4f,
              ),
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  onPageChanged: (index) {
                    controller.swipePage(index);
                  },
                  children: [
                    SingleChildScrollView(
                      controller: controller.mainScrollController,
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Column(
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.listOrder.length,
                            itemBuilder: (context, index) {
                              return OrderActiveWidget(
                                order: controller.listOrder[index],
                                topBorder: index == 0,
                                onPressed: () {
                                  controller.toDetail(controller.listOrder[index]);
                                },
                              );
                            },
                          ),
                          if (controller.isLoading.value)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 40),
                                child: LoadingWidget(),
                              ),
                            ),
                          if (!controller.isLoading.value && controller.listOrder.isEmpty)
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 100),
                                child: Column(
                                  children: [
                                    Assets.images.emptyHistory.image(width: 150),
                                    const SizedBox(height: 15),
                                    Text(
                                      'Danh sách đang trống',
                                      style: AppTextStyle.w600s20(ColorName.black222),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Bạn có thể tạo mới đơn hàng ngay lúc này!',
                                      style: AppTextStyle.w400s16(ColorName.black222),
                                    )
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    for (int i = 1; i < controller.menu.length; i++)
                      SingleChildScrollView(
                        controller: controller.currentIndexPageView.value == i
                            ? controller.orderWithStatusScrollController
                            : null,
                        padding: const EdgeInsets.only(bottom: 50),
                        child: Column(
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.listOrderWithStatus.length,
                              itemBuilder: (context, index) {
                                return OrderActiveWidget(
                                  order: controller.listOrderWithStatus[index],
                                  topBorder: index == 0,
                                  onPressed: () {
                                    controller.toDetail(controller.listOrderWithStatus[index]);
                                  },
                                );
                              },
                            ),
                            if (controller.isLoadingOrderWithStatus.value)
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 40),
                                  child: LoadingWidget(),
                                ),
                              ),
                            if (!controller.isLoadingOrderWithStatus.value && controller.listOrderWithStatus.isEmpty)
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 100),
                                  child: Column(
                                    children: [
                                      Assets.images.emptyHistory.image(width: 150),
                                      const SizedBox(height: 15),
                                      Text(
                                        'Danh sách đang trống',
                                        style: AppTextStyle.w600s20(ColorName.black222),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Bạn có thể tạo mới đơn hàng ngay lúc này!',
                                        style: AppTextStyle.w400s16(ColorName.black222),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
