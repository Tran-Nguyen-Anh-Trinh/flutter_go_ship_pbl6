import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/common.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/home_shipper/home_shipper_controller.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeShipperPage extends BaseWidget<HomeShipperController> {
  const HomeShipperPage({Key? key}) : super(key: key);

  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(16.073885, 108.149829),
    zoom: 15,
  );

  @override
  Widget onBuild(BuildContext context) {
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
              zoomGesturesEnabled: !controller.isMapDirections.value,
              scrollGesturesEnabled: !controller.isMapDirections.value,
              minMaxZoomPreference: const MinMaxZoomPreference(14.65, 19),
              cameraTargetBounds:
                  controller.isMapDirections.value ? CameraTargetBounds.unbounded : controller.latLngBounds.value,
              onMapCreated: (GoogleMapController mapController) {
                controller.mapController.complete(mapController);
              },
              polylines: Set<Polyline>.of(controller.polylines.values),
            ),
          ),
          Obx(
            () => CommonMenu(
              top: 50,
              height: 50,
              width: 50,
              right: 15,
              radius: 60,
              totalNotification: AppConfig.badge.value + 0,
              [
                {
                  0: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: N.toChatHome,
                    child: Assets.images.chatMenuIcon.image(height: 18, width: 18),
                  ),
                },
                {
                  AppConfig.badge.value: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      N.toNotification();
                    },
                    child: Assets.images.notificationMenuIcon.image(height: 18, width: 18),
                  ),
                },
              ],
            ),
          ),
          Positioned(
            bottom: kBottomNavigationBarHeight + (Platform.isIOS ? 45 : 10),
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
                  child: Assets.images.myLocationIcon.image(height: 20, width: 20),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 15, right: 80),
            child: CommonSearchBar(
              onPressed: null,
              trailingPressed: () {
                N.toSetting();
              },
              trailing: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: CachedNetworkImage(
                  height: 35,
                  width: 35,
                  fit: BoxFit.cover,
                  imageUrl: AppConfig.shipperInfo.avatarUrl ?? '',
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Assets.images.profileIcon.image(height: 35, width: 35),
                ),
              ),
              leading: Assets.images.goShipMoto.image(height: 25, width: 30),
              title: Text("Go Ship", style: AppTextStyle.w700s16(ColorName.primaryColor)),
            ),
          ),
        ],
      ),
    );
  }
}
