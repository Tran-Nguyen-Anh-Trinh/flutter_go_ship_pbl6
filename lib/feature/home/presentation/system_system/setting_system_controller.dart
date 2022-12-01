import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../utils/config/app_navigation.dart';
import '../../../../utils/services/Firebase/realtime_database.dart';
import '../../../../utils/services/storage_service.dart';

class SettingSystemController extends BaseController {
  SettingSystemController(this._realtimeDatabase, this._storageService);

  final RealtimeDatabase _realtimeDatabase;

  final StorageService _storageService;

  String defaultMessages = '';
  final path = 'default_messages/${AppConfig.accountModel.phoneNumber}';

  @override
  void onInit() {
    super.onInit();
    (_realtimeDatabase.getDefaultMessages(path))
        .then((value) => defaultMessages = value);
  }

  void backWelcomePage() async {
    await _storageService.removeToken();
    N.toWelcomePage();
  }

  void setDefaultMessages(String val) async {
    await _realtimeDatabase.setDefaultMessages(path, val);
    await (_realtimeDatabase.getDefaultMessages(path))
        .then((value) => defaultMessages = value);
  }
}
