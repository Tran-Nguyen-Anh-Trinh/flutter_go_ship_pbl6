import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_go_ship_pbl6/feature/chat/domain/entities/messages.dart';
import 'package:flutter_go_ship_pbl6/utils/services/Models/infor_user.dart';

abstract class RealtimeDatabase {
  Future<Stream<DatabaseEvent>> loadRealtimeUser();
  Future<void> sentMessages(
      String pathSent, String pathReceive, Messages messages);
  Future<Stream<DatabaseEvent>> loadMessagesRealtime(String pathSent);
  Future<Stream<DatabaseEvent>> getPhoneUsedToMessagesRealtime();
  Future<InforUser?> getUserByPhone(String phone);
  Future<Messages?> getLastMessages(String phone);
  Future<void> setNewMessages(String path, bool val);
  Future<bool> getStatusMessages(String path);
  Future<Stream<DatabaseEvent>> initGetMessages(String pathSent);
  Future<List<Messages>> loadMoreMessages(
      String pathSent, String key, Function(String saveKey) onChangeKey);
  Future<void> setDefaultMessages(String path, String val);
  Future<String> getDefaultMessages(String path);
}
