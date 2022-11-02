import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/account_model.dart';

class TabBarController extends BaseController<AccountModel> {
  TabBarController();
  final currentIndex = 0.obs;
  AccountModel? accountModel;

  @override
  void onInit() {
    super.onInit();
    accountModel = input;
  }

  void onTabSelected(int index) {
    currentIndex.value = index;
  }
}
