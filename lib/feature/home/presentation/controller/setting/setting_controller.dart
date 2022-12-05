import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/account_model.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/services/storage_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../utils/config/app_config.dart';
import '../../../data/models/customer_info_model.dart';
import '../../../domain/usecases/get_customer_info.dart';
import '../../../domain/usecases/update_customer_info_usecase.dart';

class SettingController extends BaseController {
  SettingController(this._updateCustomerInfoUsecase,
      this._getCustomeInfoUsecase, this._storageService);
  final GetCustomeInfoUsecase _getCustomeInfoUsecase;

  final StorageService _storageService;
  final UpdateCustomerInfoUsecase _updateCustomerInfoUsecase;

  String dropdownValue = '';
  Rx<CustomerModel> customerInfo = Rx<CustomerModel>(CustomerModel());

  final refreshController = RefreshController(initialRefresh: false);

  void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _getCustomeInfoUsecase.execute(
        observer: Observer(onSuccess: (customerModel) {
      AppConfig.customerInfo = customerModel;
      customerInfo.value = customerModel;
      refreshController.refreshCompleted();
    }, onError: (e) {
      refreshController.refreshCompleted();
    }));
  }

  void onLoading() async {
    await Future.delayed(const Duration(milliseconds: 200));
    refreshController.loadComplete();
  }

  @override
  void onInit() {
    super.onInit();
    customerInfo.value = AppConfig.customerInfo;
    final disteanceView = AppConfig.customerInfo.distanceView ?? 10;
    dropdownValue = '$disteanceView km';
  }

  void onSaveDistanceView(String value) {
    _updateCustomerInfoUsecase.execute(
      input: CustomerModel(
        name: AppConfig.customerInfo.name,
        address: AppConfig.customerInfo.address,
        avatarUrl: AppConfig.customerInfo.avatarUrl,
        birthDate: AppConfig.customerInfo.birthDate,
        distanceView: int.parse(value.split(' ').first),
        gender: AppConfig.customerInfo.gender,
      ),
    );
  }

  void logout() {
    showOkCancelDialog(
      cancelText: "Huỷ",
      okText: "Đăng xuất",
      message: "Bạn chắc chắn muốn đăng xuất khỏi Go Ship?",
      title: "Đăng xuất",
    ).then((value) async {
      if (value == OkCancelResult.ok) {
        await _storageService.removeToken();
        AppConfig.accountModel = AccountModel();
        N.toWelcomePage();
      }
    });
  }
}
