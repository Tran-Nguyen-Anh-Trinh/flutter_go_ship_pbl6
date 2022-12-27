import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'dart:async';
import 'dart:math';

import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/tab_bar/tab_bar_controller.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widget_to_image.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/receive_order_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/confirm_done_order_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/delivery_order_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/map/data/providers/remote/google_map_api.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/services/Firebase/realtime_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeShipperController extends BaseController {
  HomeShipperController(
    this._realtimeDatabase,
    this._deliveryOrderUsecase,
    this._confirmDonerOrderUsecase,
  );

  final RealtimeDatabase _realtimeDatabase;
  final Completer<GoogleMapController> mapController = Completer();
  final DeliveryOrderUsecase _deliveryOrderUsecase;
  final ConfirmDonerOrderUsecase _confirmDonerOrderUsecase;

  GoogleMapController? _mapController;
  LocationData? myLocation;
  Rx<CameraTargetBounds> latLngBounds = CameraTargetBounds(
    LatLngBounds(
      northeast: const LatLng(16.073885 + 0.0065 * 2 / 2, 108.149829 + 0.0065 * 2 / 2),
      southwest: const LatLng(16.073885 - 0.0065 * 2 / 2, 108.149829 - 0.0065 * 2 / 2),
    ),
  ).obs;

  RxMap<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;

  BitmapDescriptor myMarkerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
  BitmapDescriptor pinMakerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);

  double heading = 0;
  bool isClose = false;

  @override
  void onInit() {
    super.onInit();
    setMarkerIcon();
    doSomeAsyncStuff();
    FlutterCompass.events!.listen((event) {
      heading = event.heading ?? 0;
    });
  }

  @override
  void onClose() {
    locationSubscription?.cancel();
    isClose = true;
    super.onClose();
  }

  Future<void> doSomeAsyncStuff() async {
    _mapController = await mapController.future;
    getMyLocation();
    updateLoactionToFirebase();
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
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
          errorWidget: (context, url, error) => Assets.images.profileIcon.image(height: 35, width: 35),
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
        child: Assets.images.pinIcon.image(),
      ),
    )
        .then(
      (value) {
        pinMakerIcon = BitmapDescriptor.fromBytes(value);
      },
    );
  }

  StreamSubscription<LocationData>? locationSubscription;
  void getMyLocation() {
    var location = Location();

    location.getLocation().then(
      (value) async {
        myLocation = value;
        latLngBounds.value = CameraTargetBounds.unbounded;
        try {
          if (_mapController != null) {
            await _mapController!.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  bearing: 0,
                  target: LatLng(value.latitude!, value.longitude!),
                  zoom: 17.0,
                ),
              ),
            );
          }
        } catch (e) {}

        latLngBounds.value = CameraTargetBounds(
          LatLngBounds(
            northeast: LatLng(value.latitude! + 0.0065 * 5 / 2, value.longitude! + 0.0065 * 5 / 2),
            southwest: LatLng(value.latitude! - 0.0065 * 5 / 2, value.longitude! - 0.0065 * 5 / 2),
          ),
        );
      },
    );

    location.changeSettings(interval: 300);
    locationSubscription = location.onLocationChanged.listen((latLng) async {
      if (latLng.latitude != null && latLng.longitude != null) {
        setMarker(
          LatLng(latLng.latitude!, latLng.longitude!),
          AppConfig.shipperInfo.name ?? "",
          markerIcon: myMarkerIcon,
        );
        myLocation = latLng;
        if (isMapDirections.value) {
          if (isTrackingTime) {
            await _mapController!.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  bearing: heading,
                  target: LatLng(latLng.latitude!, latLng.longitude!),
                  zoom: 20.0,
                  tilt: 90,
                ),
              ),
            );
          }
        }
      }
    });
  }

  void updateLoactionToFirebase() async {
    if (isClose) return;
    await Future.delayed(const Duration(seconds: 5));
    if (myLocation?.latitude != null && myLocation?.longitude != null) {
      var latitude = myLocation?.latitude ?? 0;
      var longitude = myLocation?.longitude ?? 0;

      if (AppConfig.accountInfo.phoneNumber != null) {
        await _realtimeDatabase.updateLoaction(
          AppConfig.accountInfo.phoneNumber ?? "",
          LatLng(
            latitude,
            longitude,
          ),
          AppConfig.shipperInfo.account,
        );
      }
    }
    updateLoactionToFirebase();
  }

  void goToMyLocation() async {
    if (myLocation != null) {
      latLngBounds.value = CameraTargetBounds.unbounded;
      await goToPlace(LatLng(myLocation!.latitude!, myLocation!.longitude!));
      latLngBounds.value = CameraTargetBounds(
        LatLngBounds(
          northeast: LatLng(myLocation!.latitude! + 0.0065 * 5 / 2, myLocation!.longitude! + 0.0065 * 5 / 2),
          southwest: LatLng(myLocation!.latitude! - 0.0065 * 5 / 2, myLocation!.longitude! - 0.0065 * 5 / 2),
        ),
      );
    }
  }

  Future<void> goToPlace(LatLng latLng, {bool isSetMarker = false}) async {
    latLngBounds.value = CameraTargetBounds.unbounded;
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
    latLngBounds.value = CameraTargetBounds(
      LatLngBounds(
        northeast: LatLng(latLng.latitude + 0.0065 * 0.5 / 2, latLng.longitude + 0.0065 * 0.5 / 2),
        southwest: LatLng(latLng.latitude - 0.0065 * 0.5 / 2, latLng.longitude - 0.0065 * 0.5 / 2),
      ),
    );
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

  // Map Directions

  var isMapDirections = false.obs;
  final googleMapAPI = GoogleMapAPI();
  var isTrackingTime = false;
  LatLng? endPoint;

  void mapDirectionsModel(int? orderID, String? phoneNumber, LatLng startLatLng, LatLng endLatLng) async {
    if (myLocation?.latitude == null || myLocation?.longitude == null) return;
    var latLngs = await googleMapAPI.direct(
      LatLng(
        myLocation?.latitude ?? 0,
        myLocation?.longitude ?? 0,
      ),
      startLatLng,
      'cycling-road',
    );
    if (latLngs.isEmpty) {
      Get.snackbar(
        "Tìm đường thất bại",
        "Rất tiếc hiện tại chúng tôi không thể tìm thấy tuyến đường phù hợp cho bạn",
        margin: const EdgeInsets.symmetric(vertical: 80, horizontal: 25),
        duration: const Duration(seconds: 8),
        backgroundColor: ColorName.whiteFaf,
        snackPosition: SnackPosition.BOTTOM,
        animationDuration: const Duration(milliseconds: 300),
        boxShadows: [
          const BoxShadow(
            offset: Offset(-8, -8),
            blurRadius: 10,
            color: ColorName.gray838,
          ),
        ],
      );
      return;
    }
    setPolylines(latLngs);
    endPoint = startLatLng;
    var distance = calculateDistance(
      myLocation?.latitude,
      myLocation?.longitude,
      startLatLng.latitude,
      startLatLng.longitude,
    );
    Get.find<TabBarController>().mapDirectionsModel(
      isGoEndPoint: false,
      km: distance.toStringAsFixed(2),
      time: (distance / 25 * 60).ceilToDouble().toStringAsFixed(0),
      onClose: () {
        isMapDirections.value = false;
        isTrackingTime = false;
        polylines.clear();
        markers.remove(const MarkerId("Điểm đến"));
        goToMyLocation();
      },
      onGoEndPoint: () {
        isTrackingTime = false;
        goToEndPosition();
      },
      onGoStartPoint: () {
        isTrackingTime = false;
        goToStartPosition();
      },
      onTracking: () {
        _mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              bearing: heading,
              target: LatLng(myLocation?.latitude ?? 16, myLocation?.longitude ?? 108),
              zoom: 20.0,
              tilt: 90,
            ),
          ),
        );
        isTrackingTime = true;
      },
      onViewFull: () {
        isTrackingTime = false;
        _setMapFitToTour(polylines);
      },
      onDelivery: () async {
        isMapDirections.value = false;
        isTrackingTime = false;
        polylines.clear();
        markers.remove(const MarkerId("Điểm đến"));
        goToMyLocation();
        await launchUrl(
          Uri.parse('tel:${phoneNumber ?? "0384933379"}'),
        );
        await showOkDialog(
          title: "Xác nhận đã nhận hàng!",
          message: "Xác nhận bạn đã nhận được hàng từ khách",
        );
        _deliveryOrderUsecase.execute(
          observer: Observer(
            onSuccess: (_) async {
              String audioasset = "sound/notification.mp3";
              await AudioPlayer().play(AssetSource(audioasset), volume: 1);
              Get.snackbar(
                "Nhận hàng thành công",
                "Bắt đầu giao hàng thôi nào",
                margin: const EdgeInsets.symmetric(vertical: 90, horizontal: 25),
                duration: const Duration(seconds: 4),
                animationDuration: const Duration(milliseconds: 600),
                icon: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Assets.images.logoIcon.image(width: 25),
                ),
                backgroundGradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.1, 0.9],
                  colors: [ColorName.whiteFff, ColorName.primaryColor],
                ),
                backgroundColor: ColorName.whiteFff,
                overlayBlur: 0,
                barBlur: 1,
                boxShadows: [
                  const BoxShadow(
                    offset: Offset(8, 8),
                    blurRadius: 10,
                    color: ColorName.gray838,
                  ),
                ],
                snackStyle: SnackStyle.FLOATING,
                dismissDirection: DismissDirection.up,
              );
              mapDirectionsModelEnd(orderID, phoneNumber, endLatLng);
            },
            onError: (err) {
              if (kDebugMode) {
                printError(info: err);
              }
              Get.closeAllSnackbars();
              Get.snackbar(
                "Nhận hàng không thành công",
                "Một số lỗi đã xảy ra, vui lòng thực hiện nhận hàng lại sau vài giây",
                margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
                duration: const Duration(seconds: 4),
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
            },
          ),
          input: StatusOrderRequest(orderID),
        );
      },
    );
    isMapDirections.value = true;
  }

  void mapDirectionsModelEnd(int? orderID, String? phoneNumber, LatLng endLatLng) async {
    if (myLocation?.latitude == null || myLocation?.longitude == null) return;
    var latLngs = await googleMapAPI.direct(
      LatLng(
        myLocation?.latitude ?? 0,
        myLocation?.longitude ?? 0,
      ),
      endLatLng,
      'cycling-road',
    );
    if (latLngs.isEmpty) {
      Get.snackbar(
        "Tìm đường thất bại",
        "Rất tiếc hiện tại chúng tôi không thể tìm thấy tuyến đường phù hợp cho bạn",
        margin: const EdgeInsets.symmetric(vertical: 80, horizontal: 25),
        duration: const Duration(seconds: 8),
        backgroundColor: ColorName.whiteFaf,
        snackPosition: SnackPosition.BOTTOM,
        animationDuration: const Duration(milliseconds: 300),
        boxShadows: [
          const BoxShadow(
            offset: Offset(-8, -8),
            blurRadius: 10,
            color: ColorName.gray838,
          ),
        ],
      );
      return;
    }
    setPolylines(latLngs);
    endPoint = endLatLng;
    var distance = calculateDistance(
      myLocation?.latitude,
      myLocation?.longitude,
      endLatLng.latitude,
      endLatLng.longitude,
    );
    Get.find<TabBarController>().mapDirectionsModel(
      isGoEndPoint: true,
      km: distance.toStringAsFixed(2),
      time: (distance / 25 * 60).ceilToDouble().toStringAsFixed(0),
      onClose: () {
        isMapDirections.value = false;
        isTrackingTime = false;
        polylines.clear();
        markers.remove(const MarkerId("Điểm giao hàng"));
        goToMyLocation();
      },
      onGoEndPoint: () {
        isTrackingTime = false;
        goToEndPosition();
      },
      onGoStartPoint: () {
        isTrackingTime = false;
        goToStartPosition();
      },
      onTracking: () {
        _mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              bearing: heading,
              target: LatLng(myLocation?.latitude ?? 16, myLocation?.longitude ?? 108),
              zoom: 20.0,
              tilt: 90,
            ),
          ),
        );
        isTrackingTime = true;
      },
      onViewFull: () {
        isTrackingTime = false;
        _setMapFitToTour(polylines);
      },
      onDelivery: () async {
        isMapDirections.value = false;
        isTrackingTime = false;
        polylines.clear();
        markers.remove(const MarkerId("Điểm giao hàng"));
        goToMyLocation();
        await launchUrl(
          Uri.parse('tel:${phoneNumber ?? "0384933379"}'),
        );
        await showOkDialog(
          title: "Xác nhận đã giao hàng!",
          message: "Yêu cầu xác nhận bạn đã giao hàng thành công",
        );
        _confirmDonerOrderUsecase.execute(
          observer: Observer(
            onSuccess: (_) async {
              String audioasset = "sound/notification.mp3";
              await AudioPlayer().play(AssetSource(audioasset), volume: 1);
              Get.snackbar(
                "Đã yêu cầu xác nhận",
                "Vui lòng đợi trong giây lát yêu cầu của bạn đã được gửi tới khách hàng",
                margin: const EdgeInsets.symmetric(vertical: 90, horizontal: 25),
                duration: const Duration(seconds: 4),
                animationDuration: const Duration(milliseconds: 600),
                icon: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Assets.images.logoIcon.image(width: 25),
                ),
                backgroundGradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.1, 0.9],
                  colors: [ColorName.whiteFff, ColorName.primaryColor],
                ),
                backgroundColor: ColorName.whiteFff,
                overlayBlur: 0,
                barBlur: 1,
                boxShadows: [
                  const BoxShadow(
                    offset: Offset(8, 8),
                    blurRadius: 10,
                    color: ColorName.gray838,
                  ),
                ],
                snackStyle: SnackStyle.FLOATING,
                dismissDirection: DismissDirection.up,
              );
            },
            onError: (err) {
              if (kDebugMode) {
                printError(info: err);
              }
              Get.closeAllSnackbars();
              Get.snackbar(
                "Yêu cầu xác nhận đơn hàng không thành công",
                "Một số lỗi đã xảy ra, vui lòng thực hiện xác nhận lại sau vài giây",
                margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
                duration: const Duration(seconds: 4),
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
            },
          ),
          input: StatusOrderRequest(orderID),
        );
      },
    );
    isMapDirections.value = true;
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
          polylines.values.first.points.last.latitude,
          polylines.values.first.points.last.longitude,
        ),
        "Điểm đến",
        snippet: "Vị trí đích đến",
        markerIcon: pinMakerIcon,
      );
      _setMapFitToTour(polylines);
    }
  }

  void goToMapFitToTour() {
    _setMapFitToTour(polylines);
  }

  void goToStartPosition() async {
    if (myLocation?.latitude == null || myLocation?.longitude == null) return;
    await goToPlace(
      LatLng(
        myLocation?.latitude ?? 0,
        myLocation?.longitude ?? 0,
      ),
    );
  }

  void goToEndPosition() async {
    if (endPoint == null) return;
    await goToPlace(
      endPoint!,
    );
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
        90,
      ),
    );
  }
}
