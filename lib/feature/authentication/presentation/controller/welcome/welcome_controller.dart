import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/account_model.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';

class WelcomeController extends BaseController {
  WelcomeController();

  @override
  void onInit() {
    super.onInit();
    AppConfig.accountModel = AccountModel();
  }

  void toRegisterCustomer() {
    N.toRegisterCustomer(role: 1);
  }

  void toRegisterShipper() {
    N.toRegisterCustomer(role: 2);
  }

  void toLoginPage() {
    N.toLoginPage();
  }
}
