import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/feature/chat/domain/entities/messages.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/utils/services/Firebase/cloud_storage.dart';
import 'package:flutter_go_ship_pbl6/utils/services/Models/infor_user.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../utils/services/Firebase/realtime_database.dart';

class ChatDetailController extends BaseController<InforUser> {
  ChatDetailController(this._realtimeDatabase, this._cloudStorage);

  final RealtimeDatabase _realtimeDatabase;
  final CloudStorage _cloudStorage;

  late final InforUser userReceive;

  late final String pathSent;
  late final String pathReceive;

  final messagesList = <Messages>[].obs;
  final messagesListBackUp = <Messages>[];

  final messagesTextEditingController = TextEditingController();

  String get messagesText => messagesTextEditingController.text;

  late final Stream<DatabaseEvent> _stream;
  late final StreamSubscription _streamSubscription;

  final _picker = ImagePicker();

  final imageList = <String>[].obs;
  final urls = <String>[].obs;

  RxBool isHide = true.obs;

  String getText = '';

  String key = '';

  bool maker = true;

  final isLoading = false.obs;

  final scrollController = ScrollController();

  bool isFirst = true;

  String defaultMessages = '';

  @override
  void onInit() async {
    super.onInit();
    userReceive = input;

    pathSent =
        'messages/${AppConfig.accountModel.phoneNumber}/${userReceive.phone}';
    pathReceive =
        'messages/${userReceive.phone}/${AppConfig.accountModel.phoneNumber}';

    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (!(scrollController.position.pixels == 0)) {
          loadMoreMessages(pathSent, key);
        }
      }
    });

    final path = 'default_messages/${userReceive.phone}';

    _realtimeDatabase
        .getDefaultMessages(path)
        .then((value) => defaultMessages = value);

    _stream = await _realtimeDatabase.initGetMessages(pathSent);
    _streamSubscription = _stream.listen((event) async {
      _realtimeDatabase.setNewMessages('$pathSent/isNew', false);

      messagesListBackUp.clear();
      maker = true;
      final messagesChildren = event.snapshot.children;
      for (final it in messagesChildren) {
        try {
          messagesListBackUp
              .add(Messages.fromJson(it.value as Map<dynamic, dynamic>));
          if (maker) {
            key = it.key!;
          }
          maker = false;
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }
        }
      }
      messagesList.clear();
      messagesList.addAll(messagesListBackUp);
      if (!isFirst) {
        scrollToBottom();
      }
      isFirst = false;
    });
  }

  void loadMoreMessages(String path, String keyParam) async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1000));
    messagesList.insertAll(
        0,
        (await _realtimeDatabase.loadMoreMessages(path, keyParam, (saveKey) {
          key = saveKey;
        })));

    isLoading.value = false;
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
    scrollController.dispose();
    super.onClose();
  }

  void onTapSent() async {
    if (messagesText.trim().isEmpty && imageList.isEmpty) {
      messagesTextEditingController.text = '';
      return;
    }
    getText = messagesText;
    messagesTextEditingController.text = '';

    isHide.value = true;

    messagesList.add(Messages(
        messages: getText,
        image: imageList.map((element) => 'jpg@@').toList().join('##'),
        dateTime: DateTime.now(),
        senderPhone: AppConfig.accountModel.phoneNumber ?? ''));

    if (imageList.isNotEmpty) {
      urls.addAll(await _cloudStorage
          .putAllFile(imageList.map((element) => File(element)).toList()));
    }

    imageList.clear();

    if (messagesList.length == 1) {
      await _realtimeDatabase.sentMessages(
          pathSent,
          pathReceive,
          Messages(
              messages: getText,
              image: urls.join('##'),
              dateTime: DateTime.now(),
              senderPhone: AppConfig.accountModel.phoneNumber ?? ''));
      if (defaultMessages.isNotEmpty) {
        await _realtimeDatabase.sentMessages(
            pathSent,
            pathReceive,
            Messages(
                messages: defaultMessages,
                image: '',
                dateTime: DateTime.now(),
                senderPhone: userReceive.phone ?? ''));
      }
    } else {
      await _realtimeDatabase.sentMessages(
          pathSent,
          pathReceive,
          Messages(
              messages: getText,
              image: urls.join('##'),
              dateTime: DateTime.now(),
              senderPhone: AppConfig.accountModel.phoneNumber ?? ''));
      await _realtimeDatabase.setNewMessages('$pathReceive/isNew', true);
    }

    urls.clear();
  }

  void scrollToBottom() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(
        scrollController.position.minScrollExtent,
      );
    });
  }

  void getImageList() async {
    back();
    final images = await _picker.pickMultiImage(imageQuality: 50);
    imageList.addAll(images.map((element) => element.path).toList());
    if (imageList.isNotEmpty) {
      isHide.value = false;
    }
  }

  void getPhoto() async {
    back();
    try {
      final images =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
      imageList.add(images!.path);
      if (imageList.isNotEmpty) {
        isHide.value = false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void getVideo() async {
    back();
    try {
      final images = await _picker.pickVideo(
        source: ImageSource.gallery,
      );
      imageList.add(images!.path);
      if (imageList.isNotEmpty) {
        isHide.value = false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
