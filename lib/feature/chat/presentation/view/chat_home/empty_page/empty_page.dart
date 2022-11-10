import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

import '../../../../../../utils/config/app_text_style.dart';
import '../../../../../../utils/gen/assets.gen.dart';
import '../../../../../../utils/gen/colors.gen.dart';

part 'empty_page.g.dart';

@swidget
Widget emptyPage() {
  return Padding(
    padding: const EdgeInsets.only(left: 12, right: 12, bottom: 80),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.images.emptyIcon.image(scale: 3),
              Text(
                'Xem các cuộc trò chuyện của bạn với những người khác tại đây',
                style: AppTextStyle.w500s20(Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Bạn cũng có thể yêu cầu hỗ trợ từ chúng tôi',
                style: AppTextStyle.w400s13(ColorName.gray838),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 52),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Trò chuyện cùng Go Ship',
                style: AppTextStyle.w400s13(ColorName.gray838),
              ),
              Assets.images.arrowIcon.image(scale: 3),
            ],
          ),
        ),
      ],
    ),
  );
}
