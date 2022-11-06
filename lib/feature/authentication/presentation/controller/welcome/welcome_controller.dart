import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';

class WelcomeController extends BaseController {
  WelcomeController();

  void toRegisterCustomer() {
    N.toRegisterCustomer();
  }

  void toLoginPage() {
    N.toLoginPage();
  }
}
