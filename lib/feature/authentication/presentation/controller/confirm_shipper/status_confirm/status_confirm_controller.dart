import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/account_model.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/services/storage_service.dart';

class StatusConfirmController extends BaseController<bool> {
  StatusConfirmController(this._storageService);

  final StorageService _storageService;

  var isDeny = false.obs;
  @override
  void onInit() {
    super.onInit();
    isDeny.value = input;
  }

  void toLandingPage() {
    _storageService.removeToken().then((value) {
      AppConfig.accountInfo = AccountModel();
      N.toWelcomePage();
    });
  }

  void toConfirm() {
    N.toConfirmShipper();
  }
}
