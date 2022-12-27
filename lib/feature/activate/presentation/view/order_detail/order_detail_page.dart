import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_app_bar.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/common.dart';
import 'package:flutter_go_ship_pbl6/feature/activate/presentation/controller/order_detail/order_detail_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/activate/presentation/view/order_detail/order_detail_bindings.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailPage extends BaseWidget<OrderDetailController> {
  const OrderDetailPage({Key? key}) : super(key: key);

  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(16.073885, 108.149829),
    zoom: 15,
  );

  @override
  Widget onBuild(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: controller.contractSheet,
        child: Stack(
          children: [
            Scaffold(
              appBar: BaseAppBar(
                title: const Text('Chi tiết đơn hàng'),
              ),
              resizeToAvoidBottomInset: false,
              body: ExpandableBottomSheet(
                  key: controller.globalKey,
                  enableToggle: true,
                  background: Stack(
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
                          zoomGesturesEnabled: false,
                          scrollGesturesEnabled: false,
                          onTap: (value) => controller.contractSheet(),
                          onMapCreated: (GoogleMapController mapController) {
                            controller.mapController.complete(mapController);
                          },
                          polylines: Set<Polyline>.of(controller.polylines.values),
                        ),
                      ),
                      Positioned(
                        bottom: kBottomNavigationBarHeight + 70,
                        right: 15,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: controller.goToMyLocation,
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
                      Positioned(
                        bottom: kBottomNavigationBarHeight + 130,
                        right: 15,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: controller.goToStartPosition,
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
                              child: Assets.images.startOrderMarker.image(height: 25, width: 25),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: kBottomNavigationBarHeight + 190,
                        right: 15,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: controller.goToEndPosition,
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
                              child: Assets.images.endOrderMarker.image(height: 20, width: 20),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: kBottomNavigationBarHeight + 250,
                        right: 15,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: controller.goToMapFitToTour,
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
                              child: Assets.images.trackingIcon.image(height: 22, width: 22, color: ColorName.black000),
                            ),
                          ),
                        ),
                      ),
                      if (controller.isViewTrackingShow.value)
                        Positioned(
                          bottom: kBottomNavigationBarHeight + 310,
                          right: 15,
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: controller.goToOrderLocation,
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
                                child: Assets.images.logoIcon.image(height: 22, width: 22),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  persistentHeader: GestureDetector(
                    onTap: controller.expandSheet,
                    child: Container(
                      height: 100,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                          color: ColorName.grayF8f,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, -8),
                              blurRadius: 10,
                              color: ColorName.grayBdb,
                            )
                          ]),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 5,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: ColorName.gray838,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                const SizedBox(width: 25),
                                CupertinoButton(
                                  onPressed: () {
                                    if (controller.typeOrder.value != TypeOrderDetail.shipper) {
                                      if (controller.orderModel.value.shipper != null) {
                                        N.toShipperDetail(shipperID: '${controller.orderModel.value.shipper}');
                                      }
                                    }
                                  },
                                  padding: EdgeInsets.zero,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      height: 45,
                                      width: 45,
                                      imageUrl: controller.typeOrder.value == TypeOrderDetail.shipper
                                          ? controller.orderModel.value.customer?.avatarUrl ?? ""
                                          : controller.shipperInfo.value.avatarUrl ?? "",
                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) => Assets.images.profileIcon.image(width: 45),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.typeOrder.value == TypeOrderDetail.shipper
                                            ? controller.orderModel.value.customer?.name ?? 'Go Ship'
                                            : controller.shipperInfo.value.name ?? 'Go Ship',
                                        style: AppTextStyle.w600s16(ColorName.black222),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        controller.typeOrder.value == TypeOrderDetail.shipper
                                            ? controller.orderModel.value.customer?.account?.phoneNumber ?? '0384933379'
                                            : controller.shipperInfo.value.phoneNumber ?? 'Chưa có tài xế nhận đơn',
                                        style: AppTextStyle.w400s14(ColorName.black222),
                                      ),
                                    ],
                                  ),
                                ),
                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    if (controller.typeOrder.value == TypeOrderDetail.shipper) {
                                      launchUrl(
                                        Uri.parse(
                                            'tel:${controller.orderModel.value.customer?.account?.phoneNumber ?? '0384933379'}'),
                                      );
                                    } else {
                                      if (controller.shipperInfo.value.phoneNumber != null) {
                                        launchUrl(
                                          Uri.parse('tel:${controller.shipperInfo.value.phoneNumber ?? '0384933379'}'),
                                        );
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: ColorName.grayE0e,
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    child: Center(
                                      child: Assets.images.callIcon.image(height: 15, color: ColorName.primaryColor),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    N.toChatDetail(
                                      input: controller.inforUSer,
                                    );
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: ColorName.grayE0e,
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    child: Center(
                                      child:
                                          Assets.images.chatMenuIcon.image(height: 15, color: ColorName.primaryColor),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 25),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  expandableContent: controller.typeOrder.value == TypeOrderDetail.customerRating
                      ? Container(
                          height: 200,
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 0.5, color: ColorName.grayC7c),
                            ),
                            color: ColorName.grayF8f,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            (controller.orderModel.value.status?.id ?? 1) == 5
                                                ? 'Đơn hàng đã được xác nhận'
                                                : (controller.orderModel.value.status?.id ?? 1) == 4
                                                    ? "Đơn hàng đã hủy"
                                                    : "Xác nhận đơn hàng",
                                            style: AppTextStyle.w500s15(ColorName.black333),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${(controller.orderModel.value.distance ?? 0.000).toStringAsFixed(3)}',
                                                textAlign: TextAlign.center,
                                                style: AppTextStyle.w700s17(ColorName.black000),
                                              ),
                                              Text(
                                                ' km',
                                                textAlign: TextAlign.center,
                                                style: AppTextStyle.w500s17(ColorName.gray4f4),
                                              ),
                                              Text(
                                                ' / ',
                                                textAlign: TextAlign.center,
                                                style: AppTextStyle.w700s16(ColorName.black333),
                                              ),
                                              Text(
                                                NumberFormat('#,##0')
                                                    .format(
                                                      controller.orderModel.value.cost ?? 0,
                                                    )
                                                    .replaceAll(',', '.'),
                                                textAlign: TextAlign.center,
                                                style: AppTextStyle.w700s16(ColorName.green459),
                                              ),
                                              Text(
                                                ' đ',
                                                textAlign: TextAlign.center,
                                                style: AppTextStyle.w600s10(ColorName.redFf0),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      children: [
                                        Assets.images.shieldIcon.image(width: 25),
                                        CupertinoButton(
                                          onPressed: (controller.orderModel.value.status?.id ?? 1) == 3
                                              ? () {
                                                  controller.cofnirmDone();
                                                }
                                              : (controller.orderModel.value.status?.id ?? 1) == 5
                                                  ? () {
                                                      controller.ratingShipper();
                                                    }
                                                  : () {},
                                          child: Container(
                                            height: 40,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: (controller.orderModel.value.status?.id ?? 1) == 3
                                                  ? ColorName.primaryColor
                                                  : (controller.orderModel.value.status?.id ?? 1) == 5
                                                      ? ColorName.primaryColor
                                                      : ColorName.grayC7c,
                                            ),
                                            child: Center(
                                              child: Text(
                                                (controller.orderModel.value.status?.id ?? 1) == 5
                                                    ? 'Đánh giá tài xế'
                                                    : 'Xác nhận',
                                                style: AppTextStyle.w500s13(ColorName.whiteFff),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                StatusOrderWidget(controller.orderModel.value.status?.id ?? 1),
                                const SizedBox(height: 25),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          height: 550,
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 0.5, color: ColorName.grayC7c),
                            ),
                            color: ColorName.grayF8f,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            controller.typeOrder.value == TypeOrderDetail.shipper
                                                ? (controller.orderModel.value.status?.id ?? 1) == 1
                                                    ? 'Yêu cầu nhận đợn hàng ngay!'
                                                    : (controller.orderModel.value.status?.id ?? 1) == 4
                                                        ? "Đơn hàng đã bị hủy!"
                                                        : (controller.orderModel.value.shipper ?? 1) ==
                                                                AppConfig.shipperInfo.account
                                                            ? 'Đơn hàng của bạn'
                                                            : "Đơn hàng này đã có người nhận!"
                                                : (controller.orderModel.value.status?.id ?? 1) == 1
                                                    ? "Đang tìm tài xế"
                                                    : (controller.orderModel.value.status?.id ?? 1) == 2
                                                        ? "Tài xế đang đến"
                                                        : (controller.orderModel.value.status?.id ?? 1) == 3
                                                            ? "Xác nhận đơn hàng"
                                                            : (controller.orderModel.value.status?.id ?? 1) == 4
                                                                ? "Đơn hàng đã bị hủy!"
                                                                : "Đơn hàng đã được xác nhận",
                                            style: AppTextStyle.w500s15(ColorName.black333),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${(controller.orderModel.value.distance ?? 0.000).toStringAsFixed(3)}',
                                                textAlign: TextAlign.center,
                                                style: AppTextStyle.w700s17(ColorName.black000),
                                              ),
                                              Text(
                                                ' km',
                                                textAlign: TextAlign.center,
                                                style: AppTextStyle.w500s17(ColorName.gray4f4),
                                              ),
                                              Text(
                                                ' / ',
                                                textAlign: TextAlign.center,
                                                style: AppTextStyle.w700s16(ColorName.black333),
                                              ),
                                              Text(
                                                NumberFormat('#,##0')
                                                    .format(
                                                      controller.orderModel.value.cost ?? 0,
                                                    )
                                                    .replaceAll(',', '.'),
                                                textAlign: TextAlign.center,
                                                style: AppTextStyle.w700s16(ColorName.green459),
                                              ),
                                              Text(
                                                ' đ',
                                                textAlign: TextAlign.center,
                                                style: AppTextStyle.w600s10(ColorName.redFf0),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      children: [
                                        if (controller.orderModel.value.category?.isProtected ?? false)
                                          Assets.images.shieldIcon.image(width: 25),
                                        CupertinoButton(
                                          onPressed: controller.typeOrder.value == TypeOrderDetail.shipper
                                              ? (controller.orderModel.value.status?.id ?? 1) == 5
                                                  ? () {
                                                      controller.viewRating();
                                                    }
                                                  : (controller.orderModel.value.status?.id ?? 1) == 1
                                                      ? () {
                                                          controller.receiveOrder();
                                                        }
                                                      : (controller.orderModel.value.shipper ?? 1) ==
                                                              AppConfig.shipperInfo.account
                                                          ? () {
                                                              controller.shipperTrackingTime();
                                                            }
                                                          : () {}
                                              : (controller.orderModel.value.status?.id ?? 1) == 3
                                                  ? () {
                                                      controller.cofnirmDone();
                                                    }
                                                  : (controller.orderModel.value.status?.id ?? 1) == 5
                                                      ? () {
                                                          controller.ratingShipper();
                                                        }
                                                      : () {},
                                          child: Container(
                                            height: 40,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: controller.typeOrder.value == TypeOrderDetail.shipper
                                                    ? (controller.orderModel.value.status?.id ?? 1) == 4 ||
                                                            ((controller.orderModel.value.shipper ?? 1) !=
                                                                    AppConfig.shipperInfo.account &&
                                                                (controller.orderModel.value.status?.id ?? 1) != 1)
                                                        ? ColorName.grayC7c
                                                        : ColorName.primaryColor
                                                    : (controller.orderModel.value.status?.id ?? 1) == 3
                                                        ? ColorName.primaryColor
                                                        : (controller.orderModel.value.status?.id ?? 1) == 5
                                                            ? ColorName.primaryColor
                                                            : ColorName.grayC7c),
                                            child: Center(
                                              child: Text(
                                                controller.typeOrder.value == TypeOrderDetail.shipper
                                                    ? (controller.orderModel.value.status?.id ?? 1) == 5
                                                        ? 'Xem đánh giá'
                                                        : (controller.orderModel.value.status?.id ?? 1) == 2
                                                            ? 'Chỉ đường'
                                                            : (controller.orderModel.value.status?.id ?? 1) == 3
                                                                ? 'Chỉ đường'
                                                                : 'Nhận đơn'
                                                    : (controller.orderModel.value.status?.id ?? 1) == 5
                                                        ? 'Đánh giá tài xế'
                                                        : 'Xác nhận',
                                                style: AppTextStyle.w500s13(ColorName.whiteFff),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                StatusOrderWidget(controller.orderModel.value.status?.id ?? 1),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    Text(
                                      'Chi tiết đơn hàng:',
                                      textAlign: TextAlign.left,
                                      style: AppTextStyle.w600s15(ColorName.black222),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Text(
                                        controller.orderModel.value.description ?? '',
                                        textAlign: TextAlign.left,
                                        style: AppTextStyle.w400s14(ColorName.black222),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    Text(
                                      'Lưu ý đến bạn:',
                                      textAlign: TextAlign.left,
                                      style: AppTextStyle.w600s15(ColorName.redFf0),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Text(
                                        controller.orderModel.value.customerNotes ?? 'Không có lưu ý nào dành cho bạn!',
                                        textAlign: TextAlign.left,
                                        style: AppTextStyle.w400s14(ColorName.black222),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    Text(
                                      'Phương thức thanh toán:',
                                      textAlign: TextAlign.left,
                                      style: AppTextStyle.w600s15(ColorName.black222),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Text(
                                        controller.orderModel.value.payment?.type ?? 'Thanh toán khi nhận hàng',
                                        textAlign: TextAlign.left,
                                        style: AppTextStyle.w400s14(ColorName.black222),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    Text(
                                      'Hình ảnh mô tả:',
                                      textAlign: TextAlign.left,
                                      style: AppTextStyle.w600s15(ColorName.black222),
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: controller.orderModel.value.imgOrder ??
                                            'https://firebasestorage.googleapis.com/v0/b/pbl6-goship.appspot.com/o/order_no_image.jpg?alt=media&token=41fedf4d-dd07-434c-9c3e-c610dc4d5f76',
                                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) => Assets.images.orderNoImage.image(),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                ),
                                const SizedBox(height: 25),
                              ],
                            ),
                          ),
                        )),
            ),
            if (controller.loadState.value)
              Positioned.fill(
                child: Container(
                  color: ColorName.black000.withOpacity(0.6),
                  child: const LoadingWidget(
                    color: ColorName.whiteFff,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
