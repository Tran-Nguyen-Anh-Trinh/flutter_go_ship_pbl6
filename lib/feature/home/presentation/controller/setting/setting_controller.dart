import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/services/storage_service.dart';

class SettingController extends BaseController {
  SettingController(this._storageService);

  final StorageService _storageService;

  void logout() {
    showOkCancelDialog(
      cancelText: "Huỷ",
      okText: "Đăng xuất",
      message: "Bạn chắc chắn muốn đăng xuất khỏi Go Ship?",
      title: "Đăng xuất",
    ).then((value) async {
      if (value == OkCancelResult.ok) {
        await _storageService.removeToken();
        N.toWelcomePage();
      }
    });
  }
}
