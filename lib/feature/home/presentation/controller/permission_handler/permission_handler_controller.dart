import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/account_model.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerController extends BaseController<AccountModel> {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      fetchPermissionStatus();
    }
  }

  void fetchPermissionStatus() {
    Permission.locationWhenInUse.status.then(
      (status) {
        if (status == PermissionStatus.granted) {
          N.toTabBar();
        }
      },
    );
  }
}
