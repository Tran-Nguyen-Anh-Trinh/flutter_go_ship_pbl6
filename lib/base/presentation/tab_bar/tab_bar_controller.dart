import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/tab_bar/widgets/widget.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/account_model.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/update_token_device_request.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/domain/usecases/update_token_device_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/notification_model.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/services/Firebase/push_notification.dart';
import 'package:flutter_go_ship_pbl6/utils/services/Firebase/realtime_database.dart';
import 'package:get/get.dart';

class TabBarController extends BaseController {
  TabBarController(this._updateTokenDeviceUsecase, this._realtimeDatabase);

  final UpdateTokenDeviceUsecase _updateTokenDeviceUsecase;
  final RealtimeDatabase _realtimeDatabase;
  final currentIndex = 0.obs;
  AccountModel? accountModel;

  @override
  Future<void> onInit() async {
    super.onInit();
    accountModel = AppConfig.accountInfo;
    onListenNotification();

    _updateTokenDeviceUsecase.execute(
      observer: Observer(
        onSubscribe: () {},
        onSuccess: (_) {},
        onError: (e) {
          if (e is DioError) {
            if (e.response != null) {
              print(e.response?.data['detail'].toString());
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

  void onListenNotification() async {
    if (accountModel?.phoneNumber != null) {
      var result = await _realtimeDatabase.listenNotification(accountModel?.phoneNumber ?? "");
      result.listen(
        (data) {
          List<NotificationModel> listNotification = [];
          int bagde = 0;
          for (var item in data.snapshot.children) {
            try {
              var notification = NotificationModel.fromJson(item.value as Map<dynamic, dynamic>);
              if (!notification.isSeen!) {
                bagde = bagde + 1;
              }
              listNotification.insert(0, notification);
            } catch (e) {
              if (kDebugMode) {
                print(e.toString());
              }
            }
          }
          AppConfig.listNotification.value = listNotification;
          AppConfig.badge.value = bagde;
        },
      );
    } else {
      N.toWelcomePage();
    }
  }

  void onTabSelected(int index) {
    currentIndex.value = index;
  }

  void mapDirectionsModel({
    Function()? onClose,
    Function()? onTracking,
    Function()? onGoStartPoint,
    Function()? onGoEndPoint,
    Function()? onViewFull,
    Function()? onDelivery,
    required String? km,
    required String? time,
    required bool isGoEndPoint,
  }) {
    showModalBottomSheet(
      context: Get.context!,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.none,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      builder: (context) {
        return TrackingWidget(
          onGoEndPoint: onGoEndPoint,
          onGoStartPoint: onGoStartPoint,
          onTracking: onTracking,
          onViewFull: onViewFull,
          onDelivery: () {
            Navigator.of(context).pop();
            onDelivery?.call();
          },
          onClose: () {
            Navigator.of(context).pop();
          },
          km: km,
          time: time,
          isGoEndPoint: isGoEndPoint,
        );
      },
    ).whenComplete(() {
      onClose?.call();
    });
  }
}
