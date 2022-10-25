import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  WelcomeController();

  void toRegisterCustomer() {
    N.toRegisterCustomer();
  }

  void toLoginPage() {
    N.toLoginPage();
  }
}
