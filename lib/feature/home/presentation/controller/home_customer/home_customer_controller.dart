import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widget_to_image.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/account_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/search/search_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/map/data/models/map_position.dart';
import 'package:flutter_go_ship_pbl6/feature/map/data/models/shipper_location.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/services/Firebase/realtime_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../../../utils/config/app_config.dart';

class HomeCustomerController extends BaseController {
  HomeCustomerController(this._realtimeDatabase);
  final Completer<GoogleMapController> mapController = Completer();
  final RealtimeDatabase _realtimeDatabase;

  List<MapPosition> listPosition = List<MapPosition>.empty();
  String textSearch = "";
  Rx<bool> isSearching = false.obs;

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
  BitmapDescriptor shipperMakerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);

  @override
  void onInit() {
    super.onInit();
    setMarkerIcon();
    doSomeAsyncStuff();
  }

  Future<void> doSomeAsyncStuff() async {
    _mapController = await mapController.future;
    getMyLocation();
    listenShipperLocation();
  }

  AccountModel accountModel = AppConfig.accountInfo;

  void listenShipperLocation() async {
    if (accountModel.phoneNumber != null) {
      var result = await _realtimeDatabase.listenShipperLocation();
      result.listen(
        (data) {
          for (var item in data.snapshot.children) {
            try {
              var shipperLocation = ShipperLocation.fromJson(item.value as Map<dynamic, dynamic>, item.key);

              setMarker(
                LatLng(
                  shipperLocation.latitude!,
                  shipperLocation.longitude!,
                ),
                shipperLocation.phoneNumber!,
                markerIcon: shipperMakerIcon,
                snippet: "Tài xế Go Ship",
              );
            } catch (e) {
              if (kDebugMode) {
                print(e.toString());
              }
            }
          }
        },
      );
    } else {
      N.toWelcomePage();
    }
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
          imageUrl: AppConfig.customerInfo.avatarUrl ?? '',
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
        child: Assets.images.goShipMoto.image(),
      ),
    )
        .then(
      (value) {
        shipperMakerIcon = BitmapDescriptor.fromBytes(value);
      },
    );
  }

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

    location.changeSettings(interval: 5000);

    location.onLocationChanged.listen((event) {
      setMarker(LatLng(event.latitude!, event.longitude!), AppConfig.customerInfo.name ?? "", markerIcon: myMarkerIcon);
      myLocation = event;
    });
  }

  void goToMyLocation() async {
    listPosition = [];
    textSearch = "";
    isSearching.value = false;
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
              // tilt: 90,
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
    if (isSetMarker) {
      setMarker(latLng, textSearch, snippet: "Vị trí bạn đã tìm kiếm");
    }
  }

  void setMarker(
    LatLng latLng,
    String name, {
    BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker,
    String? snippet,
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

  void toSearch() {
    N.toSearch(inputSearch: InputSearch(listPosition, textSearch, isSearching.value));
  }
}
