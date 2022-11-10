import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/home_customer/home_customer_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/map/data/models/map_position.dart';
import 'package:flutter_go_ship_pbl6/feature/map/data/providers/remote/google_map_api.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchController extends BaseController<InputSearch?>{
  TextEditingController searchTextEditingController = TextEditingController();
  RxList<MapPosition> listPosition = List<MapPosition>.empty().obs;

  GoogleMapAPI googleMapAPI = GoogleMapAPI();
  // test
  List<String> historys = ["Bách khoa đà nẵng", "Bách khoa ĐN"];
  Rx<bool> isSearching = false.obs;

  bool searchState = false;

  final homeCustomerController = Get.find<HomeCustomerController>();

  @override
  void onInit() {
    super.onInit();
    if (input != null) {
      listPosition.value = input!.position;
      searchTextEditingController.text = input!.searchText;
      isSearching.value = input!.isSearching;
    }
  }

  void goToPlace(int index) {
    homeCustomerController.goToPlace(listPosition[index].latLng);
    homeCustomerController.listPosition = listPosition;
    homeCustomerController.textSearch = searchTextEditingController.text;
    homeCustomerController.isSearching.value = true;
    Get.back();
  }

  void serachWithHistory(int index) {
    hideKeyboard();
    searchTextEditingController.text = historys[index];
    searchPlace();
  }

  void textChangeListener(String value) {
    if (value.isEmpty) {
      listPosition.value = [];
      isSearching.value = false;
    }
  }

  void backToHome() {
    hideKeyboard();
    homeCustomerController.goToMyLocation();
    homeCustomerController.listPosition = [];
    homeCustomerController.textSearch = "";
    homeCustomerController.isSearching.value = false;
    Get.back();
  }

  void searchPlace() {
    if (searchTextEditingController.text.isNotEmpty && !searchState) {
      searchState = true;
      // production
      googleMapAPI.searchMapPlace(searchTextEditingController.text).then(
        (value) {
          listPosition.value = value;
          isSearching.value = true;
          hideKeyboard();
          searchState = false;
        },
      );
      // testing

      // listPosition.value = [
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      //   MapPosition("Bách khoa đà nẵng", const LatLng(16.073885, 108.149829)),
      // ];
      // isSearching.value = true;
      // searchState = false;

      //
    }
  }
}

class InputSearch {
  InputSearch(this.position, this.searchText, this.isSearching);
  List<MapPosition> position;
  String searchText;
  bool isSearching;
}
