import 'package:flutter/cupertino.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_app_bar.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/common.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/controller/add_address/add_address_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/controller/confirm_shipper/confirm_shipper_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/view/search/search_page.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../utils/extension/form_builder.dart';

class AddAddressPage extends BaseWidget<AddAddressController> {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  Widget onBuild(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Thêm địa chỉ"),
        backgroundColor: ColorName.whiteFff,
        foregroundColor: ColorName.primaryColor,
        centerTitle: true,
        titleTextStyle: AppTextStyle.w600s13(ColorName.black333),
        elevation: 3,
        leading: const CommonBackButton(),
        actions: [
          if (!controller.isconfirmShipperFlow)
            CupertinoButton(
              onPressed: () {
                controller.onTapSave();
              },
              child: Text(
                'Lưu',
                style: AppTextStyle.w600s13(ColorName.blue007),
              ),
            ),
        ],
        leadingWidth: 100,
        shadowColor: Colors.black26,
      ),
      body: Obx(
        () => Stack(
          children: [
            Column(
              children: [
                if (!controller.isconfirmShipperFlow)
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: CommonTextField(
                        height: 108,
                        maxLines: 10,
                        type: FormFieldType.memo,
                        textInputAction: TextInputAction.newline,
                        controller: controller.noteTextEditingController,
                        onSubmitted: (p0) {},
                      )),
                Expanded(
                  child: Stack(
                    children: [
                      GoogleMap(
                        mapType: MapType.normal,
                        markers: controller.markers.values.toSet(),
                        initialCameraPosition: CameraPosition(
                          target: controller.initialLatLng,
                          zoom: 16,
                        ),
                        myLocationEnabled: false,
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                        rotateGesturesEnabled: false,
                        mapToolbarEnabled: false,
                        zoomGesturesEnabled: false,
                        cameraTargetBounds:
                            CameraTargetBounds(controller.latLngBounds.value),
                        onMapCreated: (GoogleMapController mapController) {
                          controller.mapController.complete(mapController);
                        },
                        onTap: (latLng) {
                          controller.setMarker(
                            latLng,
                            "Go Ship",
                            "Selecting",
                            snippet: "Vị trí đã được lựa chọn",
                            onTap: () => controller.setLocation(latLng: latLng),
                          );
                          controller.goToPlace(latLng);
                          controller.setLocation(latLng: latLng);
                        },
                      ),
                      Positioned(
                        bottom: 180,
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
                              child: Assets.images.myLocationIcon
                                  .image(height: 20, width: 20),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 120,
                        right: 15,
                        child: GestureDetector(
                          onTap: controller.setLocation,
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
                              child: Assets.images.streetViewBlueIcon
                                  .image(height: 20, width: 20),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 30,
                        right: 15,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 25),
                              child:
                                  Assets.images.upArrowIcon.image(height: 50),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 55),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              decoration: BoxDecoration(
                                color: ColorName.primaryColor,
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
                                child: Text(
                                  "Sử dụng vị trí hiện tại của bạn",
                                  style:
                                      AppTextStyle.w400s11(ColorName.whiteFaf),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 15, left: 45, right: 45),
                        child: CommonSearchBar(
                          onPressed: controller.toSearch,
                          leading: Assets.images.logoIcon
                              .image(height: 30, width: 35),
                          trailing: Assets.images.streetViewRedIcon
                              .image(height: 25, width: 25),
                          title: Text("Tìm kiếm ở đây",
                              style: AppTextStyle.w400s14(ColorName.gray828)),
                        ),
                      ),
                      if (controller.isSearching.value)
                        Positioned.fill(
                          child: GestureDetector(
                            onTap: controller.hideKeyboard,
                            child: Container(
                              color: ColorName.whiteFaf,
                              height: double.infinity,
                              width: double.infinity,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, left: 45, right: 45),
                                    child: CommonSearchBar(
                                      leftPadding: 10,
                                      rightPadding: 5,
                                      leadingPressed: () {
                                        controller.isSearching.value = false;
                                      },
                                      leading: Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Assets.images.backIcon.image(
                                            width: 10,
                                            color: ColorName.primaryColor),
                                      ),
                                      trailingPressed: controller.searchPlace,
                                      trailing: Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Assets.images.searchIcon
                                            .image(height: 25, width: 25),
                                      ),
                                      title: SizedBox(
                                        child: TextField(
                                          onSubmitted: (value) {
                                            controller.searchPlace();
                                          },
                                          controller: controller
                                              .searchTextEditingController,
                                          autofocus: true,
                                          style: AppTextStyle.w400s14(
                                              ColorName.black000),
                                          showCursor: true,
                                          cursorColor: ColorName.primaryColor,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            counterText: "",
                                            hintText: "Tìm kiếm ở đây",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (!controller.searchState.value)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 10, bottom: 15),
                                      child: Text(
                                        controller.listPosition.isEmpty
                                            ? 'Không có dữ liệu'
                                            : 'Kết quả tìm kiếm',
                                        textAlign: TextAlign.left,
                                        style: AppTextStyle.w600s16(
                                            ColorName.black000),
                                      ),
                                    ),
                                  if (!controller.searchState.value)
                                    Expanded(
                                      child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          keyboardDismissBehavior:
                                              ScrollViewKeyboardDismissBehavior
                                                  .onDrag,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                controller.setMarker(
                                                  controller.listPosition[index]
                                                      .latLng,
                                                  "Go Ship",
                                                  "Selecting",
                                                  snippet:
                                                      "Vị trí đã được lựa chọn",
                                                  onTap: () =>
                                                      controller.setLocation(
                                                          latLng: controller
                                                              .listPosition[
                                                                  index]
                                                              .latLng),
                                                );
                                                controller.goToPlace(controller
                                                    .listPosition[index]
                                                    .latLng);
                                              },
                                              child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                          width: 0.5,
                                                          color: ColorName
                                                              .gray828),
                                                    ),
                                                  ),
                                                  child: commonSearchItem(
                                                    controller
                                                        .listPosition[index]
                                                        .name,
                                                    Assets
                                                        .images.searchPlaceIcon
                                                        .image(
                                                            height: 24,
                                                            width: 24),
                                                  )),
                                            );
                                          },
                                          itemCount:
                                              controller.listPosition.length),
                                    ),
                                  if (controller.searchState.value)
                                    const Expanded(
                                      child: LoadingWidget(
                                        color: ColorName.primaryColor,
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
             Obx(() => (controller.isLoading.value)
                  ? Positioned.fill(
                      child: Container(
                        color: ColorName.black000.withOpacity(0.6),
                        child: const LoadingWidget(
                          color: ColorName.whiteFff,
                        ),
                      ),
                    )
                  : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
