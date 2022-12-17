import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/feature/activate/presentation/view/order_detail_shipper/order_detail_shipper_bindings.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class PushNotification {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
    showBadge: true,
    sound: RawResourceAndroidNotificationSound("notification"),
    playSound: true,
  );

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<String?> get getDeviceToken async => await _fcm.getToken();

  Future<void> initialize() async {
    if (kDebugMode) {
      print(await getDeviceToken);
      print("======================================");
    }

    await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    AudioPlayer player = AudioPlayer();
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        RemoteNotification? notification = message.notification;

        if (notification != null) {
          String audioasset = "sound/notification.mp3";
          await player.play(AssetSource(audioasset), volume: 1);
          var type = 0;
          if (message.data["type"] != null) {
            type = int.parse(message.data["type"]);
          }
          Get.snackbar(
            notification.title ?? "",
            notification.body ?? "",
            margin: const EdgeInsets.symmetric(vertical: 90, horizontal: 25),
            duration: const Duration(seconds: 10),
            animationDuration: const Duration(milliseconds: 600),
            icon: Padding(
              padding: const EdgeInsets.all(8),
              child: Assets.images.goShipMoto.image(width: 25),
            ),
            backgroundGradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.1, 0.9],
              colors: [ColorName.whiteFff, ColorName.primaryColor],
            ),
            backgroundColor: ColorName.whiteFff,
            overlayBlur: 0,
            barBlur: 1,
            boxShadows: [
              const BoxShadow(
                offset: Offset(8, 8),
                blurRadius: 10,
                color: ColorName.gray838,
              ),
            ],
            snackStyle: SnackStyle.FLOATING,
            dismissDirection: DismissDirection.up,
            onTap: (snack) {
              Get.closeAllSnackbars();
              switch (type) {
                case 1:
                  if (message.data["order_id"] != null && message.data["time"] != null) {
                    N.toOrderDetailShipper(
                      orderDetailInput: OrderDetailShipperInput(
                        message.data["order_id"].toString(),
                        message.data["time"].toString(),
                        isRealtimeNotification: true,
                      ),
                    );
                  } else {
                    Get.snackbar(
                      "Đơn hàng không tồn tại",
                      "Đơn hàng này có thể đã bị xóa hoặc có vấn đề bạn không thể nhận đơn hàng!",
                      snackPosition: SnackPosition.BOTTOM,
                      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                      duration: const Duration(seconds: 4),
                      backgroundColor: ColorName.whiteFaf,
                      animationDuration: const Duration(milliseconds: 200),
                      boxShadows: [
                        const BoxShadow(
                          offset: Offset(-8, -8),
                          blurRadius: 10,
                          color: ColorName.gray838,
                        ),
                      ],
                    );
                  }
                  break;
                default:
              }
            },
          );
        }
      },
    );

    _fcm.getInitialMessage().then((message) {
      if (message != null) {
        RemoteNotification? notification = message.notification;
        var type = 0;
        if (notification != null) {
          if (message.data["type"] != null) {
            type = int.parse(message.data["type"]);
          }
          switch (type) {
            case 1:
              if (message.data["order_id"] != null && message.data["time"] != null) {
                N.toOrderDetailShipper(
                  orderDetailInput: OrderDetailShipperInput(
                    message.data["order_id"].toString(),
                    message.data["time"].toString(),
                    isRealtimeNotification: true,
                  ),
                );
              } else {
                Get.snackbar(
                  "Đơn hàng không tồn tại",
                  "Đơn hàng này có thể đã bị xóa hoặc có vấn đề bạn không thể nhận đơn hàng!",
                  snackPosition: SnackPosition.BOTTOM,
                  margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                  duration: const Duration(seconds: 4),
                  backgroundColor: ColorName.whiteFaf,
                  animationDuration: const Duration(milliseconds: 200),
                  boxShadows: [
                    const BoxShadow(
                      offset: Offset(-8, -8),
                      blurRadius: 10,
                      color: ColorName.gray838,
                    ),
                  ],
                );
              }
              break;
            default:
          }
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      var type = 0;
      if (notification != null) {
        if (message.data["type"] != null) {
          type = int.parse(message.data["type"]);
        }
        switch (type) {
          case 1:
            if (message.data["order_id"] != null && message.data["time"] != null) {
              N.toOrderDetailShipper(
                orderDetailInput: OrderDetailShipperInput(
                  message.data["order_id"].toString(),
                  message.data["time"].toString(),
                  isRealtimeNotification: true,
                ),
              );
            } else {
              Get.snackbar(
                "Đơn hàng không tồn tại",
                "Đơn hàng này có thể đã bị xóa hoặc có vấn đề bạn không thể nhận đơn hàng!",
                snackPosition: SnackPosition.BOTTOM,
                margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                duration: const Duration(seconds: 4),
                backgroundColor: ColorName.whiteFaf,
                animationDuration: const Duration(milliseconds: 200),
                boxShadows: [
                  const BoxShadow(
                    offset: Offset(-8, -8),
                    blurRadius: 10,
                    color: ColorName.gray838,
                  ),
                ],
              );
            }
            break;
          default:
        }
      }
    });
  }
}