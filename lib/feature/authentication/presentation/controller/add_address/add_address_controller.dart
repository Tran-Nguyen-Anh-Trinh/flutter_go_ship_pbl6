import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/controller/confirm_shipper/confirm_shipper_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/shipper_model.dart';
import 'package:flutter_go_ship_pbl6/feature/map/data/providers/remote/google_map_api.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widget_to_image.dart';
import 'package:flutter_go_ship_pbl6/feature/map/data/models/map_position.dart';
import 'package:location/location.dart';

import '../../../../../utils/config/app_config.dart';
import '../../../../home/data/providers/remote/request/customer_request.dart';
import '../../../../home/domain/usecases/update_customer_info_usecase.dart';

class AddAddressController extends BaseController<bool> {
  AddAddressController(this._updateCustomerInfoUsecase);
  final Completer<GoogleMapController> mapController = Completer();
  RxList<MapPosition> listPosition = List<MapPosition>.empty().obs;
  get kmDistance => 0.0065;
  Rx<bool> isSearching = false.obs;
  var searchState = false.obs;
  var isSetting = false;

  final searchTextEditingController = TextEditingController();

  LatLng? saveLocation;

  final UpdateCustomerInfoUsecase _updateCustomerInfoUsecase;

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

  final noteTextEditingController = TextEditingController();

  final isLoading = false.obs;

  @override
  void onClose() {
    noteTextEditingController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    isSetting = input;
    if (!isSetting) {
      var latitude = AppConfig.shipperInfo.address?.latitude ?? '';
      var longitude = AppConfig.shipperInfo.address?.longitude ?? '';
      initialLatLng = LatLng(
        double.parse(latitude.isEmpty ? "16.073885" : latitude),
        double.parse(longitude.isEmpty ? "108.149829" : longitude),
      );
      if (initialLatLng != const LatLng(16.073885, 108.149829)) {
        setMarker(
          initialLatLng,
          "Go Ship",
          "Selected",
          snippet: "V??? tr?? ???? ???????c l???a ch???n",
          markerIcon: defaultMarkerWithHue,
        );
      }
    }
    if (isSetting) {
      noteTextEditingController.text = AppConfig.customerInfo.address?.addressNotes ?? '';

      initialLatLng = LatLng(
        double.parse(AppConfig.customerInfo.address?.latitude ?? '0'),
        double.parse(AppConfig.customerInfo.address?.longitude ?? '0'),
      );

      if (initialLatLng != const LatLng(16.073885, 108.149829)) {
        setMarker(
          initialLatLng,
          "Go Ship",
          "Selected",
          snippet: "V??? tr?? ???? ???????c l???a ch???n",
          markerIcon: defaultMarkerWithHue,
        );
      }
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
        snippet: snippet ?? 'V??? tr?? hi???n t???i c???a b???n',
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

  void onTapSave() {
    hideKeyboard();
    if (noteTextEditingController.text.trim().isNotEmpty) {
      isLoading.value = true;
      if (saveLocation != null) {
        _updateCustomerInfoUsecase.execute(
          observer: Observer(onSuccess: (account) {
            isLoading.value = false;
            showOkDialog(message: "C????p nh????t tha??nh c??ng").then((value) {
              if (value == OkCancelResult.ok) {
                back();
              }
            });
            if (account != null) {
              AppConfig.customerInfo = account;
            }
          }, onError: () {
            isLoading.value = false;
            showOkDialog(message: "Opps! Co?? l????i xa??y ra");
          }),
          input: CustomerRequest(
            name: AppConfig.customerInfo.name,
            address: AddressModel(
              id: AppConfig.customerInfo.address?.id,
              addressNotes: noteTextEditingController.text.trim(),
              latitude: saveLocation?.latitude.toString(),
              longitude: saveLocation?.longitude.toString(),
            ),
            avatarUrl: AppConfig.customerInfo.avatarUrl,
            birthDate: AppConfig.customerInfo.birthDate,
            distanceView: AppConfig.customerInfo.distanceView,
            gender: AppConfig.customerInfo.gender,
          ),
        );
      } else {
        if (noteTextEditingController.text.trim().isNotEmpty) {
          _updateCustomerInfoUsecase.execute(
            observer: Observer(onSuccess: (account) {
              isLoading.value = false;
              showOkDialog(message: "C????p nh????t tha??nh c??ng").then((value) {
                if (value == OkCancelResult.ok) {
                  back();
                }
              });
              if (account != null) {
                AppConfig.customerInfo = account;
              }
            }, onError: () {
              isLoading.value = false;
              showOkDialog(message: "Opps! Co?? l????i xa??y ra");
            }),
            input: CustomerRequest(
              name: AppConfig.customerInfo.name,
              address: AddressModel(
                id: AppConfig.customerInfo.address?.id,
                addressNotes: noteTextEditingController.text.trim(),
                latitude: AppConfig.customerInfo.address?.latitude,
                longitude: AppConfig.customerInfo.address?.longitude,
              ),
              avatarUrl: AppConfig.customerInfo.avatarUrl,
              birthDate: AppConfig.customerInfo.birthDate,
              distanceView: AppConfig.customerInfo.distanceView,
              gender: AppConfig.customerInfo.gender,
            ),
          );
        } else {
          showOkDialog(message: 'Vui lo??ng cho??n vi?? tri?? cu??a ba??n');
        }
      }
    } else {
      showOkDialog(
        title: 'C???p nh???t v??? tr?? th???t b???i',
        message: 'Vui lo??ng ??i???n m?? t??? ?????a ch??? c???a b???n',
      );
    }
  }

  void setLocation({LatLng? latLng}) {
    if (latLng != null) {
      showOkCancelDialog(
        cancelText: "H???y",
        okText: "X??c nh???n",
        message: "Sau khi x??c nh???n Go Ship s??? x??c ?????nh ????y l?? ?????a ch??? c?? tr?? c???a b???n?",
        title: "B???n mu???n s??? d???ng v??? tr?? n??y?",
      ).then((value) {
        if (value == OkCancelResult.ok) {
          if (!isSetting) {
            var confirmShipperController = Get.find<ConfirmShipperController>();
            var select = latLng;
            confirmShipperController.shipper.value.address = AddressModel();
            AppConfig.shipperInfo.address = AddressModel();
            confirmShipperController.shipper.value.address!.latitude = '${select.latitude}';
            confirmShipperController.shipper.value.address!.longitude = '${select.longitude}';
            AppConfig.shipperInfo.address!.latitude = '${select.latitude}';
            AppConfig.shipperInfo.address!.longitude = '${select.longitude}';
            confirmShipperController.shipper.refresh();
            back();
          } else {
            saveLocation = latLng;
          }
        }
      });
    } else {
      showOkCancelDialog(
        cancelText: "H???y",
        okText: "X??c nh???n",
        message: "Sau khi x??c nh???n Go Ship s??? x??c ?????nh ????y l?? ?????a ch??? c?? tr?? c???a b???n?",
        title: "B???n mu???n s??? d???ng v??? tr?? hi???n t???i c???a ban?",
      ).then((value) {
        if (value == OkCancelResult.ok) {
          if (!isSetting) {
            var confirmShipperController = Get.find<ConfirmShipperController>();
            var select = myLocation != null
                ? LatLng(myLocation!.latitude ?? 16.073885, myLocation!.longitude ?? 108.149829)
                : const LatLng(16.073885, 108.149829);
            confirmShipperController.shipper.value.address = AddressModel();
            AppConfig.shipperInfo.address = AddressModel();
            confirmShipperController.shipper.value.address!.latitude = '${select.latitude}';
            confirmShipperController.shipper.value.address!.longitude = '${select.longitude}';
            AppConfig.shipperInfo.address!.latitude = '${select.latitude}';
            AppConfig.shipperInfo.address!.longitude = '${select.longitude}';
            confirmShipperController.shipper.refresh();
            back();
          }
          if (isSetting) {
            saveLocation = latLng;
          }
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
