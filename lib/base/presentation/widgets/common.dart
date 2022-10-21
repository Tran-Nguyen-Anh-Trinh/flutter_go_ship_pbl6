import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:get/route_manager.dart';

import '../../../utils/config/app_text_style.dart';
import '../../../utils/gen/assets.gen.dart';
import '../../../utils/gen/colors.gen.dart';

part 'common.g.dart';

@swidget
Widget commonBackButton({void Function()? onPressed}) {
  return CupertinoButton(
    onPressed: () {
      if (onPressed != null) {
        onPressed.call();
      } else {
        Get.back();
      }
    },
    child: Row(
      children: [
        Assets.images.backIcon.image(width: 8),
        const SizedBox(width: 10),
        Text(
          'Back',
          style: AppTextStyle.w600s13(ColorName.green4c8),
        ),
      ],
    ),
  );
}

@swidget
Widget commonCloseButton({void Function()? onPressed}) {
  return CupertinoButton(
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.only(left: 6),
    onPressed: () {
      if (onPressed != null) {
        onPressed.call();
      } else {
        Get.back();
      }
    },
    child: Assets.images.closeIcon.image(width: 30),
  );
}

@swidget
Widget loadingWidget() {
  return const Center(
    child: CupertinoActivityIndicator(color: ColorName.black000),
  );
}

// Error dialog
@swidget
Widget errorDialog({
  Widget? title,
  Widget? content,
  void Function()? onPressed,
}) {
  return CupertinoAlertDialog(
    title: title,
    content: content,
    actions: [
      TextButton(
        onPressed: () {
          if (onPressed != null) {
            onPressed.call();
          }
        },
        child: const Text('OK'),
      ),
    ],
  );
}
