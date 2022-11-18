import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/home_customer/home_customer_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/map/data/models/map_position.dart';
import 'package:flutter_go_ship_pbl6/feature/map/data/providers/remote/google_map_api.dart';
import 'package:flutter_go_ship_pbl6/utils/services/storage_service.dart';
import 'package:get/get.dart';

class SearchController extends BaseController<InputSearch?> {
  SearchController(this._storageService);

  final StorageService _storageService;
  TextEditingController searchTextEditingController = TextEditingController();
  RxList<MapPosition> listPosition = List<MapPosition>.empty().obs;

  GoogleMapAPI googleMapAPI = GoogleMapAPI();
  // test
  RxList<String> historys = <String>[].obs;
  Rx<bool> isSearching = false.obs;

  var searchState = false.obs;

  final homeCustomerController = Get.find<HomeCustomerController>();

  @override
  void onInit() {
    super.onInit();
    // test
    // _storageService.removeSearchHistory();
    loadHistory();
    if (input != null) {
      listPosition.value = input!.position;
      searchTextEditingController.text = input!.searchText;
      isSearching.value = input!.isSearching;
    }
  }

  void loadHistory() {
    _storageService.getSearchHistory().then((value) {
      historys.value = value;
    });
  }

  void goToPlace(int index) {
    if (!historys.contains(searchTextEditingController.text)) {
      historys.add(searchTextEditingController.text);
      _storageService.setSearchHistory(historys);
    }
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
    if (searchTextEditingController.text.isNotEmpty && !searchState.value) {
      searchState.value = true;

      googleMapAPI.searchMapPlace(searchTextEditingController.text).then(
        (value) {
          listPosition.value = value;
          isSearching.value = true;
          hideKeyboard();
          searchState.value = false;
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
