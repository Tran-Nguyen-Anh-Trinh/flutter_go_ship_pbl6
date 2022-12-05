import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/account_model.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/update_token_device_request.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/domain/usecases/update_token_device_usecase.dart';
import 'package:flutter_go_ship_pbl6/utils/services/Firebase/push_notification.dart';

class TabBarController extends BaseController<AccountModel> {
  TabBarController(this._updateTokenDeviceUsecase);

  final UpdateTokenDeviceUsecase _updateTokenDeviceUsecase;
  final currentIndex = 0.obs;
  AccountModel? accountModel;

  @override
  Future<void> onInit() async {
    super.onInit();
    accountModel = input;

    _updateTokenDeviceUsecase.execute(
      observer: Observer(
        onSubscribe: () {},
        onSuccess: (_) {
        },
        onError: (e) {
          if (e is DioError) {
            if (e.response != null) {
              print(e.response!.data['detail'].toString());
            } else {
              print(e.message);
            }
          }
          if (kDebugMode) {
            print(e.toString());
          }
        },
      ),
      input: UpdateTokenDeviceRequest(await PushNotification().getDeviceToken ?? ""),
    );
  }

  void onTabSelected(int index) {
    currentIndex.value = index;
  }
}
