import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/account_model.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/token_request%20.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/domain/usecases/token_refresh_usecase.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_shipper_info_usecase.dart';
import 'package:flutter_go_ship_pbl6/utils/services/storage_service.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../utils/config/app_navigation.dart';

class RootController extends BaseController {
  RootController(this._storageService, this._getShipperInfoUsecase, this._refreshTokenUsecase);
  final StorageService _storageService;
  final GetShipperInfoUsecase _getShipperInfoUsecase;
  final RefreshTokenUsecase _refreshTokenUsecase;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 200)).whenComplete(() async {
      FlutterNativeSplash.remove();
    });
    appStart();
  }

  void appStart() {
    _storageService.getToken().then((value) async {
      AccountModel account = AccountModel();

      if (value.isNotEmpty) {
        account = AccountModel.fromJson(jsonDecode(value));
        if (kDebugMode) {
          print(account.toJson());
        }
        AppConfig.accountModel = account;
        if (account.role == 1) {
          await checkPermisson(account);
        } else {
          _getShipperInfoUsecase.execute(
            observer: Observer(
              onSubscribe: () {},
              onSuccess: (shipper) async {
                print(shipper.toJson());
                await _storageService.setShipper(shipper.toJson().toString());
                if (shipper.confirmed == 0) {
                  N.toConfirmShipper();
                } else if (shipper.confirmed == 1) {
                  N.toStatusConfirm(isDeny: false);
                } else if (shipper.confirmed == 2) {
                  await checkPermisson(account);
                } else {
                  N.toStatusConfirm(isDeny: true);
                }
              },
              onError: (e) async {
                if (kDebugMode) {
                  print(e.response!.data['detail'].toString());
                  print(e);
                }
                if (e is DioError) {
                  if (e.response!.statusCode == 403) {
                    await _refreshTokenUsecase.execute(
                      observer: Observer(
                        onSubscribe: () {},
                        onSuccess: (token) {
                          account.accessToken = token.access;
                          _storageService.setToken(account.toJson().toString());
                          AppConfig.accountModel = account;
                          appStart();
                        },
                        onError: (err) async {
                          print(err);
                          if (err is DioError) {
                            if (err.response!.statusCode == 401) {
                              await showOkDialog(
                                title: "Phiên đăng nhập của bạn đã hết hạng",
                                message: "Vui lòng thực hiện đăng nhập lại!",
                              );
                              _storageService.removeToken();
                              AppConfig.accountModel = AccountModel();
                              N.toWelcomePage();
                              N.toLoginPage();
                            } else {
                              appStart();
                            }
                          }
                        },
                      ),
                      input: TokenRequest(account.refreshToken, account.accessToken),
                    );
                  } else {
                    appStart();
                  }
                }
              },
            ),
          );
        }
      } else {
        N.toWelcomePage();
      }
    });
  }

  Future<void> checkPermisson(AccountModel account) async {
    final permissionStatus = await Permission.locationWhenInUse.status;
    if (permissionStatus.isGranted) {
      N.toTabBar(account: account);
    } else {
      N.toPermissionHandler(account: account);
    }
  }
}
