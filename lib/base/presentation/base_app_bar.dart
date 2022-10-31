import 'package:flutter/material.dart';

import '../../utils/config/app_text_style.dart';
import '../../utils/gen/colors.gen.dart';
import 'widgets/common.dart';

class BaseAppBar extends AppBar {
  BaseAppBar({
    ShapeBorder? shape,
    Color? backgroundColor = ColorName.whiteFff,
    Color? foregroundColor = ColorName.primaryColor,
    Color? shadowColor = Colors.black26,
    Widget? title,
    double? titleSpacing,
    List<Widget>? actions,
    Widget? leading = const CommonBackButton(),
    double? elevation = 3,
    bool centerTitle = true,
    Key? key,
  }) : super(
          key: key,
          shape: shape,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          centerTitle: centerTitle,
          title: title,
          titleSpacing: titleSpacing,
          titleTextStyle: AppTextStyle.w600s13(ColorName.black333),
          elevation: elevation,
          leading: leading,
          actions: actions,
          leadingWidth: 100,
          shadowColor: shadowColor,
        );
}
