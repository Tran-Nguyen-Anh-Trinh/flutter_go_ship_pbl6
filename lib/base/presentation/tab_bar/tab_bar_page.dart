import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/tab_bar/widgets/app_tab_bar.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/tab_bar/widgets/centerx_docked_fab_location.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/tab_bar/widgets/circular_notched_and_cornered_shape.dart';
import 'package:flutter_go_ship_pbl6/feature/activate/presentation/view/activate_customer/activate_customer_page.dart';
import 'package:flutter_go_ship_pbl6/feature/activate/presentation/view/activate_shipper/activate_shipper_page.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/view/home_customer/home_customer_page.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/view/home_shipper/home_shipper_page.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';

import './tab_bar_controller.dart';

enum TabType { home, activate }

extension TabItem on TabType {
  String get label {
    switch (this) {
      case TabType.home:
        return "Trang chủ";
      case TabType.activate:
        return "Hoạt động";
    }
  }

  Widget get icon {
    switch (this) {
      case TabType.home:
        return Assets.images.homeIcon.image(color: ColorName.primaryColor);
      case TabType.activate:
        return Assets.images.activateIcon.image(color: ColorName.primaryColor);
    }
  }

  Widget get inactiveIcon {
    switch (this) {
      case TabType.home:
        return Assets.images.homeIcon.image(color: ColorName.gray838);
      case TabType.activate:
        return Assets.images.activateIcon.image(color: ColorName.gray838);
    }
  }

  BottomNavigationBarItem get item {
    return BottomNavigationBarItem(icon: inactiveIcon, activeIcon: icon, label: label);
  }
}

class TabBarPage extends BaseWidget<TabBarController> {
  final _items = TabType.values.map((e) => e.item).toList();

  @override
  Widget onBuild(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: (controller.accountModel!.role == 1)
              ? [
                  HomeCustomerPage(),
                  const ActivateCustomerPage(),
                ]
              : [
                  const HomeShipperPage(),
                  const ActivateShipperPage(),
                ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocationExtension.centerXDocked,
        floatingActionButton: CupertinoButton(
          padding: const EdgeInsets.only(bottom: 15),
          child: controller.accountModel!.role == 1
              ? Assets.images.addIcon.image(width: 75, height: 75)
              : Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(65),
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.01, 0.35],
                      colors: [ColorName.black222, ColorName.primaryColor],
                    ),
                  ),
                  child: Center(
                    child: Assets.images.settingIcon.image(
                      width: 35,
                      height: 35,
                      color: ColorName.whiteFff,
                    ),
                  ),
                ),
          onPressed: () {
            if (controller.accountModel!.role == 1) {
              N.toCreateOrder();
            } else {
              N.toSetting();
            }
          },
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 21,
          color: ColorName.backgroundColor,
          shape: CircularNotchedAndCorneredRectangle(),
          notchMargin: 2,
          child: AppTabBar(
            items: _items,
            selectedIndex: controller.currentIndex.value,
            onItemSelected: controller.onTabSelected,
          ),
        ),
      ),
    );
  }
}
