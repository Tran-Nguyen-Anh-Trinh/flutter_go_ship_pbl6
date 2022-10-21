import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

export 'package:get/get_rx/get_rx.dart';
export 'package:get/instance_manager.dart';

export '../domain/base_observer.dart';
export '../domain/base_state.dart';

class BaseController<T> extends SuperController {
  T get input => Get.arguments;

  late Future<OkCancelResult> Function(Exception e) showRetryError;

  late Future<OkCancelResult> Function({
    String? title,
    String? message,
  }) showOkDialog;

  late Future<OkCancelResult> Function({
    String? title,
    String? message,
    String? okText,
    String? cancelText,
  }) showOkCancelDialog;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  void back() {
    Get.back();
  }

  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
