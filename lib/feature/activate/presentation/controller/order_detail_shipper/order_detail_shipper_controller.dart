import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'dart:async';

import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/tab_bar/tab_bar_controller.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/tab_bar/tab_bar_page.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widget_to_image.dart';
import 'package:flutter_go_ship_pbl6/feature/activate/presentation/view/order_detail_shipper/order_detail_shipper_bindings.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/order_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/receive_order_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_order_detail_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/receive_order_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/home_shipper/home_shipper_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/map/data/providers/remote/google_map_api.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_route.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/services/Firebase/realtime_database.dart';
import 'package:flutter_go_ship_pbl6/utils/services/Models/infor_user.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailShipperController
    extends BaseController<OrderDetailShipperInput> {
  OrderDetailShipperController(
    this._getOrderDetailUsecase,
    this._receiveOrderUsecase,
    this._realtimeDatabase,
  );

  final GetOrderDetailUsecase _getOrderDetailUsecase;
  final RealtimeDatabase _realtimeDatabase;
  final ReceiveOrderUsecase _receiveOrderUsecase;
  final Completer<GoogleMapController> mapController = Completer();
  GoogleMapAPI googleMapAPI = GoogleMapAPI();
  late InforUser? inforUSer;

  GoogleMapController? _mapController;
  LocationData? myLocation;

  RxMap<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;

  BitmapDescriptor myMarkerIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
  BitmapDescriptor startMarkerIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose);
  BitmapDescriptor endMarkerIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose);

  Rx<OrderModel> orderModel = OrderModel().obs;
  var loadState = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    setMarkerIcon();
    try {
      doSomeAsyncStuff();
    } catch (e) {
      await showOkDialog(
        title: "Đơn hàng không tồn tại",
        message:
            "Đơn hàng này có thể đã bị xóa hoặc có vấn đề bạn không thể nhận đơn hàng!",
      );
      back();
    }
  }

  Future<void> doSomeAsyncStuff() async {
    await _getOrderDetailUsecase.execute(
      observer: Observer(
        onSubscribe: () {
          loadState.value = true;
        },
        onSuccess: ((order) async {
          print(order.toJson());
          orderModel.value = order;
          _realtimeDatabase.seemNotification(
            AppConfig.accountInfo.phoneNumber ?? "-1",
            input.notificationID,
          );

          inforUSer = await _realtimeDatabase.getUserByPhone(
              orderModel.value.customer?.account?.phoneNumber ?? '0343440509');
        }),
        onError: (error) async {
          if (error is DioError) {
            if (error.response != null) {
              print(error.response!.data['detail'].toString());
            } else {
              print(error.message);
            }
          }
          if (kDebugMode) {
            print(error.toString());
          }
          await showOkDialog(
            title: "Đơn hàng không tồn tại",
            message:
                "Đơn hàng này có thể đã bị xóa hoặc có vấn đề bạn không thể nhận đơn hàng!",
          );
          back();
        },
      ),
      input: int.parse(input.orderID),
    );
    _mapController = await mapController.future;
    goToPlace(
      LatLng(
        double.parse(orderModel.value.addressStart?.latitude ?? "0"),
        double.parse(orderModel.value.addressStart?.longitude ?? "0"),
      ),
    );
    googleMapAPI
        .direct(
      LatLng(
        double.parse(orderModel.value.addressStart?.latitude ?? "0"),
        double.parse(orderModel.value.addressStart?.longitude ?? "0"),
      ),
      LatLng(
        double.parse(orderModel.value.addressEnd?.latitude ?? "0"),
        double.parse(orderModel.value.addressEnd?.longitude ?? "0"),
      ),
      'cycling-road',
    )
        .then(
      (value) {
        setPolylines(value);
        loadState.value = false;
      },
    );
    getMyLocation();
  }

  RxMap<PolylineId, Polyline> polylines = <PolylineId, Polyline>{}.obs;

  void setPolylines(List<LatLng> polylineCoordinates) async {
    String polylineId = 'PolylineID';
    Polyline polyline = Polyline(
      polylineId: PolylineId(polylineId),
      color: ColorName.primaryColor,
      width: 10,
      points: polylineCoordinates,
    );
    polylines[PolylineId(polylineId)] = polyline;

    if (polyline.points.isNotEmpty) {
      setMarker(
        LatLng(
          polylines.values.first.points.first.latitude,
          polylines.values.first.points.first.longitude,
        ),
        "Điểm xuất phát",
        snippet:
            orderModel.value.addressStart?.addressNotes ?? "Vị trí nhận hàng",
        markerIcon: startMarkerIcon,
      );
      setMarker(
        LatLng(
          polylines.values.first.points.last.latitude,
          polylines.values.first.points.last.longitude,
        ),
        "Điểm đến",
        snippet:
            orderModel.value.addressEnd?.addressNotes ?? "Vị trí giao hàng",
        markerIcon: endMarkerIcon,
      );

      _setMapFitToTour(polylines);
    }
  }

  void goToStartPosition() async {
    await goToPlace(
      LatLng(
        polylines.values.first.points.first.latitude,
        polylines.values.first.points.first.longitude,
      ),
    );
  }

  void goToEndPosition() async {
    await goToPlace(
      LatLng(
        polylines.values.first.points.last.latitude,
        polylines.values.first.points.last.longitude,
      ),
    );
  }

  void goToMapFitToTour() {
    _setMapFitToTour(polylines);
  }

  void _setMapFitToTour(Map<PolylineId, Polyline> points) {
    double minLat = points.values.first.points.first.latitude;
    double minLong = points.values.first.points.first.longitude;
    double maxLat = points.values.first.points.first.latitude;
    double maxLong = points.values.first.points.first.longitude;
    for (var poly in points.values) {
      for (var point in poly.points) {
        if (point.latitude < minLat) minLat = point.latitude;
        if (point.latitude > maxLat) maxLat = point.latitude;
        if (point.longitude < minLong) minLong = point.longitude;
        if (point.longitude > maxLong) maxLong = point.longitude;
      }
    }
    _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat, minLong),
          northeast: LatLng(maxLat, maxLong),
        ),
        80,
      ),
    );
  }

  void setMarkerIcon() {
    WidgetToImage()
        .captureFromWidget(
      ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: CachedNetworkImage(
          height: 40,
          width: 40,
          fit: BoxFit.cover,
          imageUrl: AppConfig.shipperInfo.avatarUrl ?? '',
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) =>
              Assets.images.profileIcon.image(height: 35, width: 35),
        ),
      ),
    )
        .then(
      (value) {
        myMarkerIcon = BitmapDescriptor.fromBytes(value);
      },
    );
    WidgetToImage()
        .captureFromWidget(
      Container(
        height: 40,
        width: 40,
        padding: EdgeInsets.zero,
        child: Assets.images.startOrderMarker.image(),
      ),
    )
        .then(
      (value) {
        startMarkerIcon = BitmapDescriptor.fromBytes(value);
      },
    );
    WidgetToImage()
        .captureFromWidget(
      Container(
        height: 40,
        width: 40,
        padding: EdgeInsets.zero,
        child: Assets.images.endOrderMarker.image(),
      ),
    )
        .then(
      (value) {
        endMarkerIcon = BitmapDescriptor.fromBytes(value);
      },
    );
  }

  void getMyLocation() {
    var location = Location();

    location.getLocation().then(
      (value) async {
        myLocation = value;
      },
    );

    location.changeSettings(interval: 5000);

    location.onLocationChanged.listen((event) {
      setMarker(
        LatLng(event.latitude!, event.longitude!),
        AppConfig.shipperInfo.name ?? "",
        markerIcon: myMarkerIcon,
      );
      myLocation = event;
    });
  }

  void goToMyLocation() async {
    if (myLocation != null) {
      await goToPlace(LatLng(myLocation!.latitude!, myLocation!.longitude!));
    }
  }

  Future<void> goToPlace(LatLng latLng, {bool isSetMarker = false}) async {
    try {
      if (_mapController != null) {
        await _mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              bearing: 0,
              target: latLng,
              zoom: 17.0,
            ),
          ),
        );
      }
    } catch (e) {}
  }

  void setMarker(
    LatLng latLng,
    String name, {
    String? snippet,
    BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker,
  }) {
    // test
    setMarkerIcon();
    //
    final marker = Marker(
      consumeTapEvents: false,
      markerId: MarkerId(name),
      onTap: () {
        globalKey.currentState?.contract();
      },
      position: latLng,
      icon: markerIcon,
      infoWindow: InfoWindow(
        title: name,
        snippet: snippet ?? 'Vị trí hiện tại của bạn',
      ),
    );

    markers[MarkerId(name)] = marker;
    markers.refresh();
  }

  GlobalKey<ExpandableBottomSheetState> globalKey = GlobalKey();

  void expandSheet() {
    if (globalKey.currentState?.expansionStatus == ExpansionStatus.expanded) {
      globalKey.currentState?.contract();
    } else {
      globalKey.currentState?.expand();
    }
  }

  void contractSheet() {
    globalKey.currentState?.contract();
  }

  void receiveOrder() {
    loadState.value = true;
    try {
      contractSheet();
      _receiveOrderUsecase.execute(
        observer: Observer(
          onSuccess: (_) async {
            await showOkDialog(
              title: "Nhận đơn hàng thành công!",
              message: "Vui lòng liên hệ khách hàng để xác nhận đơn hàng!",
            );
            await launchUrl(
              Uri.parse(
                  'tel:${orderModel.value.customer?.account?.phoneNumber ?? "0384933379"}'),
            );
            Get.find<HomeShipperController>().mapDirectionsModel(
              orderModel.value.id,
              orderModel.value.customer?.account?.phoneNumber,
              LatLng(
                double.parse(orderModel.value.addressStart?.latitude ?? "0"),
                double.parse(orderModel.value.addressStart?.longitude ?? "0"),
              ),
              LatLng(
                double.parse(orderModel.value.addressEnd?.latitude ?? "0"),
                double.parse(orderModel.value.addressEnd?.longitude ?? "0"),
              ),
            );
            if (!input.isRealtimeNotification) {
              back();
            }
            back();
            loadState.value = false;
          },
          onError: (error) {
            if (error is DioError) {
              if (error.response != null) {
                print(error.response!.data['detail'].toString());
              } else {
                print(error.message);
              }
            }
            if (kDebugMode) {
              print(error.toString());
            }
            showErrorReceiveOrder();
          },
        ),
        input: StatusOrderRequest(int.parse(input.orderID)),
      );
    } catch (e) {
      showErrorReceiveOrder();
    }
  }

  void showErrorReceiveOrder() {
    back();
    Get.snackbar(
      "Đơn hàng không còn tồn tại",
      "Tiếc quá, bạn chậm một bước rồi.\nĐơn hàng này đã có người nhận, chờ đơn hàng khác nhé!",
      margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
      duration: const Duration(seconds: 8),
      backgroundColor: ColorName.whiteFaf,
      animationDuration: const Duration(milliseconds: 300),
      boxShadows: [
        const BoxShadow(
          offset: Offset(-8, -8),
          blurRadius: 10,
          color: ColorName.gray838,
        ),
      ],
    );
  }
}
