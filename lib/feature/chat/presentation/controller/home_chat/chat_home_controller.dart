import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/chat/domain/entities/messages.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/utils/services/Firebase/realtime_database.dart';

import '../../../../../utils/services/Models/infor_user.dart';

class ChatHomeController extends BaseController {
  ChatHomeController(this._realtimeDatabase);

  final RealtimeDatabase _realtimeDatabase;

  late final Stream<DatabaseEvent> _stream;
  late final StreamSubscription _streamSubscription;

  final userList = <UserDataItem>[].obs;

  final userListBackUp = <UserDataItem>[];

  final chatHomeState = BaseState();

  bool isNew = false;

  @override
  void onInit() async {
    super.onInit();
    chatHomeState.onLoading();
    await Future.delayed(const Duration(milliseconds: 700));
    _stream = (await _realtimeDatabase.getPhoneUsedToMessagesRealtime());
    _streamSubscription = _stream.listen((event) async {
      userListBackUp.clear();
      for (final phone in event.snapshot.children) {
        final user = (await _realtimeDatabase.getUserByPhone(phone.key ?? ''));
        final messages = (await _realtimeDatabase.getLastMessages(phone.key ?? ''));

        isNew = await _realtimeDatabase
            .getStatusMessages('messages/${AppConfig.accountInfo.phoneNumber}/${phone.key}/isNew');

        try {
          userListBackUp.removeWhere((it) => it.inforUser.phone == user?.phone);
          userListBackUp.add(
            UserDataItem(
              user!,
              messages!,
              user.phone! != messages.senderPhone ? 'Bạn' : user.name!,
              isNew,
            ),
          );
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }
        }
      }
      userList.clear();
      userList.addAll(userListBackUp);
      print('==========');
      print(userList.length);
      chatHomeState.onSuccess();
    });
  }

  void setNewMessages(String path) async {
    await _realtimeDatabase.setNewMessages(path, false);
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
    super.onClose();
  }
}

class UserDataItem {
  UserDataItem(this.inforUser, this.messages, this.sender, this.isNew);

  InforUser inforUser;
  Messages messages;
  String sender;
  bool isNew;
}
