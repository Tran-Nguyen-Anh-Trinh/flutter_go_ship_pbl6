import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/account_model.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/update_token_device_request.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/domain/usecases/update_token_device_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/shipper_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/customer_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/shipper_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_shipper_info_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/update_shipper_info_usecase.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/services/storage_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../utils/config/app_config.dart';
import '../../../data/models/customer_info_model.dart';
import '../../../domain/usecases/get_customer_info.dart';
import '../../../domain/usecases/update_customer_info_usecase.dart';

class SettingController extends BaseController {
  SettingController(
    this._updateCustomerInfoUsecase,
    this._getCustomeInfoUsecase,
    this._storageService,
    this._getShipperInfoUsecase,
    this._updateTokenDeviceUsecase,
    this._updateShipperInfoUsecase,
  );
  final GetCustomeInfoUsecase _getCustomeInfoUsecase;
  final GetShipperInfoUsecase _getShipperInfoUsecase;
  final StorageService _storageService;
  final UpdateCustomerInfoUsecase _updateCustomerInfoUsecase;
  final UpdateShipperInfoUsecase _updateShipperInfoUsecase;
  final UpdateTokenDeviceUsecase _updateTokenDeviceUsecase;

  String dropdownValue = '';
  Rx<CustomerModel> customerInfo = Rx<CustomerModel>(CustomerModel());
  Rx<ShipperModel> shipperInfo = Rx<ShipperModel>(ShipperModel());
  Rx<AccountModel> accountInfo = Rx<AccountModel>(AccountModel());
  final refreshController = RefreshController(initialRefresh: false);

  var isLoading = false.obs;

  void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (accountInfo.value.role == 1) {
      _getCustomeInfoUsecase.execute(
        observer: Observer(
          onSuccess: (customerModel) {
            AppConfig.customerInfo = customerModel;
            customerInfo.value = customerModel;
            refreshController.refreshCompleted();
          },
          onError: (e) {
            refreshController.refreshCompleted();
          },
        ),
      );
    } else {
      _getShipperInfoUsecase.execute(
        observer: Observer(
          onSuccess: (shipper) {
            AppConfig.shipperInfo = shipper;
            shipperInfo.value = shipper;
            refreshController.refreshCompleted();
          },
          onError: (e) {
            refreshController.refreshCompleted();
          },
        ),
      );
    }
  }

  void onLoading() async {
    await Future.delayed(const Duration(milliseconds: 200));
    refreshController.loadComplete();
  }

  @override
  void onInit() {
    super.onInit();
    customerInfo.value = AppConfig.customerInfo;
    shipperInfo.value = AppConfig.shipperInfo;
    accountInfo.value = AppConfig.accountInfo;
    final disteanceView = AppConfig.customerInfo.distanceView ?? 10;
    dropdownValue = '$disteanceView km';
  }

  void onSaveDistanceView(String value) {
    if (accountInfo.value.role == 1) {
      _updateCustomerInfoUsecase.execute(
        observer: Observer(
          onSuccess: (account) {
            if (account != null) {
              AppConfig.customerInfo = account;
              customerInfo.value = account;
            }
          },
        ),
        input: CustomerRequest(
          name: AppConfig.customerInfo.name,
          address: AppConfig.customerInfo.address,
          avatarUrl: AppConfig.customerInfo.avatarUrl,
          birthDate: AppConfig.customerInfo.birthDate,
          distanceView: int.parse(value.split(' ').first),
          gender: AppConfig.customerInfo.gender,
        ),
      );
    } else {
      _updateShipperInfoUsecase.execute(
        observer: Observer(
          onSuccess: (account) {
            if (account != null) {
              AppConfig.shipperInfo = account;
              shipperInfo.value = account;
            }
          },
        ),
        input: ShipperRequest(
          avatarUrl: AppConfig.shipperInfo.avatarUrl,
          distanceReceive: int.parse(value.split(' ').first),
        ),
      );
    }
  }

  void logout() {
    showOkCancelDialog(
      cancelText: "Huỷ",
      okText: "Đăng xuất",
      message: "Bạn chắc chắn muốn đăng xuất khỏi Go Ship?",
      title: "Đăng xuất",
    ).then((value) async {
      if (value == OkCancelResult.ok) {
        refreshController.requestRefresh();
        isLoading.value = true;
        _updateTokenDeviceUsecase.execute(
          observer: Observer(
            onSuccess: (_) async {
              await _storageService.removeToken();
              await CachedNetworkImage.evictFromCache(
                  customerInfo.value.avatarUrl ?? "");
              await CachedNetworkImage.evictFromCache(
                  shipperInfo.value.avatarUrl ?? "");
              AppConfig.accountInfo = AccountModel();
              AppConfig.customerInfo = CustomerModel();
              AppConfig.shipperInfo = ShipperModel();
              N.toWelcomePage();
              refreshController.refreshCompleted();
              isLoading.value = false;
            },
            onError: (e) {
              showOkDialog(
                message:
                    "Hệ thống gặp một số trục trặc, vui lòng thực hiện lại sau vài giây",
                title: "Đăng xuất thất bại",
              );
              refreshController.refreshCompleted();
              isLoading.value = false;
            },
          ),
          input: UpdateTokenDeviceRequest(""),
        );
      }
    });
  }
}
