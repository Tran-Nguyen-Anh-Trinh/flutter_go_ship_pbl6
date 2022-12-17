import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/services/Models/infor_user.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

import '../../../../domain/entities/messages.dart';

part 'user_item.g.dart';

@swidget
Widget userItem({
  required InforUser inforUser,
  required Messages messages,
  required String sender,
  required bool isNew,
  Function()? onPressed,
}) {
  return CupertinoButton(
    padding: EdgeInsets.zero,
    onPressed: onPressed,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Assets.images.adminIcon.image(scale: 3),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: CachedNetworkImage(
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                  imageUrl: inforUser.avatar ?? '',
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Assets.images.profileIcon.image(height: 60, width: 60),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    inforUser.name ?? '',
                    style: AppTextStyle.w700s14(Colors.black),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (messages.messages != null)
                        if (messages.messages!.isEmpty)
                          Text(
                            '$sender: Đã gửi một file',
                            style: isNew
                                ? AppTextStyle.w600s12(ColorName.black000)
                                : AppTextStyle.w400s12(ColorName.gray838),
                          ),
                      if (messages.messages != null)
                        if (messages.messages!.isNotEmpty)
                          Text(
                            '$sender: ${messages.messages}',
                            style: isNew
                                ? AppTextStyle.w600s12(ColorName.black000)
                                : AppTextStyle.w400s12(ColorName.gray838),
                          ),
                      Text(
                        '\t•\t ${handleTime(messages.dateTime)}',
                        style: isNew
                            ? AppTextStyle.w600s12(ColorName.black000)
                            : AppTextStyle.w400s12(ColorName.gray838),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        const Divider(
          height: 1,
          thickness: 1,
          color: ColorName.grayC7c,
        ),
      ],
    ),
  );
}

String handleTime(DateTime dateTime) {
  final now = DateTime.now().day;
  final day = dateTime.day;
  if (now - day == 0) {
    return DateFormat('HH:mm').format(dateTime);
  }
  return DateFormat('HH:mm dd/MM/yyyy').format(dateTime);
}
