import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/controller/confirm_shipper/confirm_shipper_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/map/data/providers/remote/google_map_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widget_to_image.dart';
import 'package:flutter_go_ship_pbl6/feature/map/data/models/map_position.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:location/location.dart';

class AddAddressController extends BaseController {
  final Completer<GoogleMapController> mapController = Completer();
  RxList<MapPosition> listPosition = List<MapPosition>.empty().obs;
  get kmDistance => 0.0065;
  Rx<bool> isSearching = false.obs;
  var searchState = false.obs;

  final searchTextEditingController = TextEditingController();

  GoogleMapController? _mapController;
  LocationData? myLocation;
  Rx<LatLngBounds?> latLngBounds = LatLngBounds(
    northeast: const LatLng(16.073885 + 0.0065 * 2 / 2, 108.149829 + 0.0065 * 2 / 2),
    southwest: const LatLng(16.073885 - 0.0065 * 2 / 2, 108.149829 - 0.0065 * 2 / 2),
  ).obs;

  RxMap<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;

  BitmapDescriptor myMarkerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
  BitmapDescriptor defaultMarkerWithHue = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);

  var initialLatLng = const LatLng(16.073885, 108.149829);

  @override
  void onInit() {
    super.onInit();
    var confirmShipperController = Get.find<ConfirmShipperController>();
    var latitude = confirmShipperController.shipper.value.address!.latitude!;
    var longitude = confirmShipperController.shipper.value.address!.longitude!;
    initialLatLng = LatLng(
      double.parse(latitude.isEmpty ? "16.073885" : latitude),
      double.parse(longitude.isEmpty ? "108.149829" : longitude),
    );
    if (initialLatLng != const LatLng(16.073885, 108.149829)) {
      setMarker(
        initialLatLng,
        "Go Ship",
        "Selected",
        snippet: "Vị trí đã được lựa chọn",
        markerIcon: defaultMarkerWithHue,
      );
    }
    setMarkerIcon();
    doSomeAsyncStuff();
  }

  Future<void> doSomeAsyncStuff() async {
    _mapController = await mapController.future;
    getMyLocation();
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
  }

  void getMyLocation() {
    var location = Location();

    location.getLocation().then(
      (value) async {
        myLocation = value;
        try {
          if (_mapController != null && initialLatLng == const LatLng(16.073885, 108.149829)) {
            await _mapController!.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  bearing: 0,
                  target: LatLng(value.latitude!, value.longitude!),
                  zoom: 16.0,
                ),
              ),
            );
          }
        } catch (e) {}

        latLngBounds.value = LatLngBounds(
          northeast: LatLng(value.latitude! + kmDistance * 5 / 2, value.longitude! + kmDistance * 5 / 2),
          southwest: LatLng(value.latitude! - kmDistance * 5 / 2, value.longitude! - kmDistance * 5 / 2),
        );
      },
    );

    location.changeSettings(interval: 5000);

    location.onLocationChanged.listen((event) {
      setMarker(
        LatLng(event.latitude ?? 16, event.longitude ?? 108),
        'Go Ship',
        "Your",
        markerIcon: myMarkerIcon,
      );
      myLocation = event;
    });
  }

  void goToMyLocation() {
    isSearching.value = false;
    if (myLocation != null) {
      goToPlace(LatLng(myLocation!.latitude!, myLocation!.longitude!));
      latLngBounds.value = LatLngBounds(
        northeast: LatLng(myLocation!.latitude! + kmDistance * 5 / 2, myLocation!.longitude! + kmDistance * 5 / 2),
        southwest: LatLng(myLocation!.latitude! - kmDistance * 5 / 2, myLocation!.longitude! - kmDistance * 5 / 2),
      );
    }
  }

  void goToPlace(LatLng latLng) async {
    isSearching.value = false;
    latLngBounds.value = LatLngBounds(
      northeast: LatLng(latLng.latitude + kmDistance * 0.5 / 2, latLng.longitude + kmDistance * 0.5 / 2),
      southwest: LatLng(latLng.latitude - kmDistance * 0.5 / 2, latLng.longitude - kmDistance * 0.5 / 2),
    );

    try {
      if (_mapController != null) {
        await _mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              bearing: 0,
              target: latLng,
              zoom: 16.0,
            ),
          ),
        );
      }
    } catch (e) {}
  }

  void setMarker(
    LatLng latLng,
    String name,
    String id, {
    BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker,
    String? snippet,
    bool showMarkerInfoWindow = false,
    Function()? onTap,
  }) {
    if (kDebugMode) setMarkerIcon();
    final marker = Marker(
      consumeTapEvents: false,
      markerId: MarkerId(id),
      position: latLng,
      icon: markerIcon,
      onTap: onTap,
      infoWindow: InfoWindow(
        title: name,
        snippet: snippet ?? 'Vị trí hiện tại của bạn',
      ),
    );

    markers[MarkerId(id)] = marker;
    markers.refresh();
    if (showMarkerInfoWindow) {
      _mapController!.showMarkerInfoWindow(markers.values.last.markerId);
    }
  }

  void toSearch() {
    isSearching.value = true;
  }

  void setLocation({LatLng? latLng}) {
    if (latLng != null) {
      showOkCancelDialog(
        cancelText: "Hủy",
        okText: "Xác nhận",
        message: "Sau khi xác nhận Go Ship sẽ xác định đây là địa chỉ cư trú của bạn?",
        title: "Bạn muốn sử dụng vị trí này?",
      ).then((value) {
        if (value == OkCancelResult.ok) {
          var confirmShipperController = Get.find<ConfirmShipperController>();
          var select = latLng;
          confirmShipperController.shipper.value.address!.latitude = '${select.latitude}';
          confirmShipperController.shipper.value.address!.longitude = '${select.longitude}';
          confirmShipperController.shipper.refresh();
          back();
        }
      });
    } else {
      showOkCancelDialog(
        cancelText: "Hủy",
        okText: "Xác nhận",
        message: "Sau khi xác nhận Go Ship sẽ xác định đây là địa chỉ cư trú của bạn?",
        title: "Bạn muốn sử dụng vị trí hiện tại của ban?",
      ).then((value) {
        if (value == OkCancelResult.ok) {
          var confirmShipperController = Get.find<ConfirmShipperController>();
          var select = myLocation != null
              ? LatLng(myLocation!.latitude ?? 16.073885, myLocation!.longitude ?? 108.149829)
              : const LatLng(16.073885, 108.149829);
          confirmShipperController.shipper.value.address!.latitude = '${select.latitude}';
          confirmShipperController.shipper.value.address!.longitude = '${select.longitude}';
          confirmShipperController.shipper.refresh();
          back();
        }
      });
    }
  }

  GoogleMapAPI googleMapAPI = GoogleMapAPI();

  void searchPlace() {
    if (searchTextEditingController.text.isNotEmpty && !searchState.value) {
      searchState.value = true;

      googleMapAPI.searchMapPlace(searchTextEditingController.text).then(
        (value) {
          listPosition.value = value;
          hideKeyboard();
          searchState.value = false;
        },
      );
    }
  }
}