import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/utils/services/Firebase/cloud_storage.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';

class CloudStorageImpl implements CloudStorage {
  final _instance = FirebaseStorage.instance;
  late Reference _reference;
  late DateTime now;
  late String formattedDate;
  final List<String> urls = [];
  @override
  Future<List<String>> putAllFile(List<File> files) async {
    _reference = _instance.ref();
    urls.clear();
    for (final it in files) {
      try {
        now = DateTime.now();
        formattedDate = DateFormat('dd-MM-yyyy-kk:mm:ssss').format(now);
        await _reference
            .child(
                'messages/${AppConfig.accountModel.phoneNumber}/$formattedDate.${isImages(it.path) ? 'jpg' : 'mp4'}')
            .putFile(it);
        urls.add(await _reference
            .child(
                'messages/${AppConfig.accountModel.phoneNumber}/$formattedDate.${isImages(it.path) ? 'jpg' : 'mp4'}')
            .getDownloadURL());
      } on Exception catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    return urls;
  }
}

bool isImages(String path) {
  String? mimeStr = lookupMimeType(path);
  try {
    if (mimeStr!.contains('image')) {
      return true;
    }
    return false;
  } catch (e) {
    return false;
  }
}
