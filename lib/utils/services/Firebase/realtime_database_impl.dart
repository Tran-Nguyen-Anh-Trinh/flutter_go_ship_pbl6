import 'dart:async';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_go_ship_pbl6/feature/chat/domain/entities/messages.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/utils/services/Firebase/realtime_database.dart';

import '../Models/infor_user.dart';

class RealtimeDatabaseImpl implements RealtimeDatabase {
  final _instance = FirebaseDatabase.instance;

  final List<String> _phoneList = [];

  final List<Messages> messagesList = [];

  late DatabaseReference _reference;

  bool maker = true;

  @override
  Future<Stream<DatabaseEvent>> loadRealtimeUser() async {
    final pathSent = 'messages/${AppConfig.accountModel.phoneNumber}';
    _reference = _instance.ref(pathSent);
    final stream = _reference.onValue;
    return stream;
  }

  @override
  Future<void> sentMessages(
      String pathSent, String pathReceive, Messages messages) async {
    _reference = _instance.ref();
    await _reference.child(pathSent).push().set(messages.toJson());
    await _reference.child(pathReceive).push().set(messages.toJson());
  }

  @override
  Future<Stream<DatabaseEvent>> loadMessagesRealtime(String pathSent) async {
    _reference = _instance.ref(pathSent);
    return _reference.onValue;
  }

  @override
  Future<Stream<DatabaseEvent>> getPhoneUsedToMessagesRealtime() async {
    _reference =
        _instance.ref().child('messages/${AppConfig.accountModel.phoneNumber}');
    return _reference.onValue;
  }

  @override
  Future<InforUser?> getUserByPhone(String phone) async {
    _reference = _instance.ref();
    try {
      final user = JsonMapper.deserialize<InforUser>(
          (await _reference.get()).child('users/$phone').value)!;
      return user;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  @override
  Future<Messages?> getLastMessages(String phone) async {
    _reference = _instance.ref();
    final snap = await (_reference
        .child('messages/${AppConfig.accountModel.phoneNumber}/$phone')
        .orderByKey()
        .limitToLast(2)
        .get());
    try {
      final messages =
          Messages.fromJson(snap.children.first.value as Map<dynamic, dynamic>);
      return messages;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  @override
  Future<void> setNewMessages(String path, bool val) async {
    _reference = _instance.ref();
    _reference.child(path).set(val);
  }

  @override
  Future<bool> getStatusMessages(String path) async {
    _reference = _instance.ref();
    try {
      final res = (await _reference.child(path).get()).value as bool;
      return res;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Stream<DatabaseEvent>> initGetMessages(String pathSent) async {
    _reference = _instance.ref(pathSent);
    return _reference.orderByKey().limitToLast(25).onValue;
  }

  @override
  Future<List<Messages>> loadMoreMessages(
      String pathSent, String key, Function(String) onChangeKey) async {
    _reference = _instance.ref(pathSent);
    final dataSnapshot =
        await _reference.orderByKey().endBefore(key).limitToLast(10).get();
    messagesList.clear();
    maker = true;
    for (final it in dataSnapshot.children) {
      try {
        messagesList.add(Messages.fromJson(it.value as Map<dynamic, dynamic>));
        if (maker) {
          key = it.key!;
          onChangeKey(key);
        }
        maker = false;
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }
    return messagesList;
  }
}
