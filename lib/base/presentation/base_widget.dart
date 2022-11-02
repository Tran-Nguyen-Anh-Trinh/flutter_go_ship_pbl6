import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import 'base_controller.dart';
export 'package:flutter/material.dart';
export 'package:get/get_state_manager/get_state_manager.dart';

abstract class BaseWidget<Controller extends BaseController> extends GetWidget<Controller> {
  const BaseWidget({Key? key}) : super(key: key);
  @protected
  Widget onBuild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    _onInit(context);
    return onBuild(context);
  }

  void _onInit(BuildContext context) {
    controller.showOkCancelDialog = ({String? title, String? message, String? okText, String? cancelText}) {
      return showOkCancelAlertDialog(
        context: context,
        title: title,
        message: message,
        okLabel: okText ?? 'Xác nhận',
        cancelLabel: cancelText ?? 'Hủy',
      );
    };

    controller.showOkDialog = ({String? title, String? message}) {
      return showOkAlertDialog(
        context: context,
        title: title,
        message: message,
      );
    };
  }
}
