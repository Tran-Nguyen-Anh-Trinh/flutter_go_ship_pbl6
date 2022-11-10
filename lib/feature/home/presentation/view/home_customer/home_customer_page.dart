import 'package:flutter/cupertino.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/common.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/home_customer/home_customer_controller.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/services/storage_service.dart';
import 'package:flutter_go_ship_pbl6/utils/services/storage_service_impl.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeCustomerPage extends GetView<HomeCustomerController> {
  HomeCustomerPage({Key? key}) : super(key: key);

  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(16.073885, 108.149829),
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Obx(
            () => GoogleMap(
              mapType: MapType.normal,
              markers: controller.markers.values.toSet(),
              initialCameraPosition: _initialCameraPosition,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              rotateGesturesEnabled: false,
              minMaxZoomPreference: const MinMaxZoomPreference(14.65, 19),
              cameraTargetBounds:
                  CameraTargetBounds(controller.latLngBounds.value),
              onMapCreated: (GoogleMapController mapController) {
                controller.mapController.complete(mapController);
              },
              onTap: (argument) {
                print(
                  controller.calculateDistance(
                      16.073885, 108.149829, 16.090669, 108.142748),
                );

                print(
                  controller.calculateDistance(16.073885, 108.149829,
                      16.073885 - 0.0065 * 5, 108.149829 + 0.0065 * 5),
                );
              },
            ),
          ),
          CommonMenu(
            top: 50,
            height: 50,
            width: 50,
            right: 15,
            radius: 60,
            totalNotification: 8,
            [
              {
                3: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: N.toChatHome,
                  child:
                      Assets.images.chatMenuIcon.image(height: 18, width: 18),
                ),
              },
              {
                5: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  child: Assets.images.notificationMenuIcon
                      .image(height: 18, width: 18),
                ),
              },
              // testing
              {
                1: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    StorageServiceImpl().removeToken().then((value) {
                      N.toWelcomePage();
                    });
                  },
                  child: Assets.images.notificationMenuIcon
                      .image(height: 18, width: 18),
                ),
              },
              // testing
            ],
          ),
          Positioned(
            bottom: kBottomNavigationBarHeight + 10,
            right: 15,
            child: GestureDetector(
              onTap: controller.goToMyLocation,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: ColorName.whiteFff,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0.0, 4.0),
                      blurRadius: 4,
                      color: ColorName.black000.withOpacity(0.25),
                    ),
                  ],
                ),
                child: Center(
                  child:
                      Assets.images.myLocationIcon.image(height: 20, width: 20),
                ),
              ),
            ),
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.only(top: 50, left: 15, right: 80),
              child: controller.isSearching.value
                  ? CommonSearchBar(
                      onPressed: controller.toSearch,
                      leftPadding: 10,
                      rightPadding: 5,
                      leading:
                          Assets.images.logoIcon.image(height: 30, width: 35),
                      trailingPressed: controller.goToMyLocation,
                      trailing: Container(
                        padding: const EdgeInsets.all(10),
                        child: Assets.images.closeIcon.image(
                            height: 30,
                            width: 30,
                            color: ColorName.primaryColor),
                      ),
                      title: Text(controller.textSearch,
                          style: AppTextStyle.w400s14(ColorName.black000)),
                    )
                  : CommonSearchBar(
                      onPressed: controller.toSearch,
                      leading:
                          Assets.images.logoIcon.image(height: 30, width: 35),
                      trailing: Assets.images.profileMaleIcon
                          .image(height: 35, width: 35),
                      title: Text("Tìm kiếm ở đây",
                          style: AppTextStyle.w400s14(ColorName.gray828)),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
