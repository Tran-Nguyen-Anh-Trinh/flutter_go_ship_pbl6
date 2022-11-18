import 'dart:convert';

import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/account_model.dart';
import 'package:flutter_go_ship_pbl6/utils/services/storage_service.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../utils/config/app_navigation.dart';

class RootController extends GetxController {
  RootController(this._storageService);
  final StorageService _storageService;
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 1)).whenComplete(() async {
      FlutterNativeSplash.remove();
      _storageService.getToken().then((value) async {
        AccountModel account = AccountModel();
        if (value.isNotEmpty) {
          account = AccountModel.fromJson(jsonDecode(value));
          print(account.toJson());
          final permissionStatus = await Permission.locationWhenInUse.status;
          if (permissionStatus.isGranted) {
            N.toTabBar(account: account);
          } else {
            N.toPermissionHandler(account: account);
          }
        } else {
          N.toWelcomePage();
        }
      });
    });
  }
}
