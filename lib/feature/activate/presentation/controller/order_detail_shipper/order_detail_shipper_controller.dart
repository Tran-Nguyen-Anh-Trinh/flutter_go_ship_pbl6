import 'package:dio/dio.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'dart:async';

import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widget_to_image.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/order_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/receive_order_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_order_detail_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/receive_order_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/map/data/providers/remote/google_map_api.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailShipperController extends BaseController<String> {
  OrderDetailShipperController(this._getOrderDetailUsecase, this._receiveOrderUsecase);

  final GetOrderDetailUsecase _getOrderDetailUsecase;
  final ReceiveOrderUsecase _receiveOrderUsecase;
  final Completer<GoogleMapController> mapController = Completer();
  GoogleMapAPI googleMapAPI = GoogleMapAPI();

  GoogleMapController? _mapController;
  LocationData? myLocation;

  RxMap<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;

  BitmapDescriptor myMarkerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
  BitmapDescriptor startMarkerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose);
  BitmapDescriptor endMarkerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose);

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
        message: "Đơn hàng này có thể đã bị xóa hoặc có vấn đề bạn không thể nhận đơn hàng!",
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
        onSuccess: ((order) {
          print(order.toJson());
          orderModel.value = order;
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
            message: "Đơn hàng này có thể đã bị xóa hoặc có vấn đề bạn không thể nhận đơn hàng!",
          );
          back();
        },
      ),
      input: int.parse(input),
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
        snippet: orderModel.value.addressStart?.addressNotes ?? "Vị trí nhận hàng",
        markerIcon: startMarkerIcon,
      );
      setMarker(
        LatLng(
          polylines.values.first.points.last.latitude,
          polylines.values.first.points.last.longitude,
        ),
        "Điểm đến",
        snippet: orderModel.value.addressEnd?.addressNotes ?? "Vị trí giao hàng",
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
      Container(
        height: 40,
        width: 40,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(150)),
          border: Border.all(width: 3, color: ColorName.primaryColor),
        ),
        child: Assets.images.profileIcon.image(),
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
        AppConfig.shipperModel.name ?? "",
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
              Uri.parse('tel:${orderModel.value.customer?.account?.phoneNumber ?? "0384933379"}'),
            );
            // open tracking map
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
        input: ReceiveOrderRequest(int.parse(input)),
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
