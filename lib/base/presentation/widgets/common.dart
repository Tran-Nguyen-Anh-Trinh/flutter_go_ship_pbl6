import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_go_ship_pbl6/utils/extension/form_builder.dart';
import 'package:flutter_go_ship_pbl6/base/domain/base_state.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

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
      mainAxisSize: MainAxisSize.min,
      children: [
        Assets.images.backIcon.image(width: 8, color: ColorName.primaryColor),
        const SizedBox(width: 10),
        Text(
          'Quay lại',
          style: AppTextStyle.w500s13(ColorName.primaryColor),
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
Widget loadingWidget({Color? color}) {
  return Center(
    child: CupertinoActivityIndicator(color: color ?? ColorName.black000),
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

@swidget
Widget commonTextField(
  BuildContext textFieldContext, {
  GlobalKey<FormBuilderState>? formKey,
  required FormFieldType type,
  bool obscureText = false,
  bool isEnable = true,
  int? maxLines = 1,
  int? maxLength,
  String? initialValue,
  TextEditingController? controller,
  TextInputAction? textInputAction = TextInputAction.next,
  void Function()? onTap,
  void Function(String?)? onChanged,
  void Function(String?)? onSubmitted,
  Widget? suffixIcon,
  void Function()? onPressedSuffixIcon,
  double height = 72,
}) {
  final ctl = controller ?? TextEditingController();
  return Theme(
    data: Theme.of(textFieldContext).copyWith(
      primaryColor: ColorName.redFf3,
    ),
    child: SizedBox(
      height: height,
      child: Focus(
        child: Builder(
          builder: (BuildContext context) {
            final FocusNode focusNode = Focus.of(context);
            final bool hasFocus = focusNode.hasFocus;
            return FormBuilderTextField(
              scrollPadding: const EdgeInsets.all(36.0),
              maxLines: maxLines,
              initialValue: initialValue,
              name: type.name,
              maxLength: maxLength,
              style: AppTextStyle.w400s13(ColorName.black333),
              keyboardType: type.keyboardType,
              textAlignVertical: TextAlignVertical.center,
              textInputAction: textInputAction,
              obscureText: obscureText,
              cursorColor: ColorName.blue007,
              cursorWidth: 1.5,
              controller: ctl,
              enabled: isEnable,
              decoration: InputDecoration(
                counterText: "",
                errorMaxLines: 2,
                isDense: true,
                labelText: type.labelText,
                labelStyle: const TextStyle(fontSize: 11),
                alignLabelWithHint: true,
                filled: true,
                fillColor: hasFocus ? ColorName.whiteFff : ColorName.grayF8f,
                hintText: type.hintText,
                hintStyle: AppTextStyle.w400s13(ColorName.grayC7c),
                errorStyle: AppTextStyle.w400s13(ColorName.redFf3, height: 0.7),
                contentPadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 16),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: ColorName.gray838, width: 0.5),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: ColorName.blue007, width: 1),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: ColorName.redFf3, width: 1),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: ColorName.redFf3, width: 1),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: ColorName.gray838, width: 0.5),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                suffixIcon: suffixIcon == null
                    ? null
                    : CupertinoButton(
                        minSize: 0,
                        padding: const EdgeInsets.only(right: 8),
                        onPressed: onPressedSuffixIcon,
                        child: suffixIcon,
                      ),
              ),
              validator: type.validator(),
              onTap: formKey?.formBuilderState == null || type.validator() == null
                  ? null
                  : () {
                      final text = ctl.text;
                      final field = type.field(formKey!.formBuilderState!);
                      if (type.validator() != null) {
                        field.validate();
                        field.reset();
                        ctl.value = ctl.value.copyWith(
                          text: text,
                          selection: TextSelection.collapsed(offset: text.length),
                        );
                      }
                      onTap?.call();
                    },
              onChanged: formKey?.formBuilderState == null || type.validator() == null
                  ? null
                  : (v) {
                      final text = ctl.text;
                      final field = type.field(formKey!.formBuilderState!);
                      if (type.validator() != null && field.hasError) {
                        field.validate();
                        field.reset();
                        ctl.value = ctl.value.copyWith(
                          text: text,
                          selection: TextSelection.collapsed(offset: text.length),
                        );
                      }
                      onChanged?.call(v);
                    },
              onSubmitted: onSubmitted ??
                  (_) {
                    FocusScope.of(context).nextFocus();
                  },
            );
          },
        ),
      ),
    ),
  );
}

@swidget
Widget commonDropDown({
  required String title,
  String? value,
  void Function()? onPressed,
  double height = 50,
}) {
  return CupertinoButton(
    padding: EdgeInsets.zero,
    onPressed: onPressed,
    child: Container(
      margin: const EdgeInsets.only(bottom: 22),
      height: height,
      decoration: BoxDecoration(
        color: value != null ? ColorName.whiteFff : ColorName.grayF8f,
        border: Border.all(color: ColorName.gray838, width: 0.5),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(width: 13),
          Text(
            value ?? title,
            style: AppTextStyle.w400s11(value != null ? ColorName.black000 : ColorName.gray838),
          ),
          const Spacer(),
          const Icon(Icons.keyboard_arrow_down, color: ColorName.black000),
          const SizedBox(width: 13),
        ],
      ),
    ),
  );
}

@swidget
Widget commonButton({
  required Widget child,
  double? width,
  double height = 44,
  Function()? onPressed,
  Color fillColor = ColorName.primaryColor,
  Color? borderColor,
  double borderWidth = 1,
  BorderRadiusGeometry? borderRadius,
  BaseState? state,
  Color indicatorColor = Colors.white,
}) {
  return SizedBox(
    width: width,
    height: height,
    child: CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: fillColor,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(8),
            side: BorderSide(
              width: borderWidth,
              color: borderColor ?? fillColor,
            ),
          ),
        ),
        child: state != null
            ? state.widget(
                onLoading: Center(
                  child: CupertinoActivityIndicator(color: indicatorColor),
                ),
                onEmpty: child,
              )
            : child,
      ),
    ),
  );
}

@swidget
Widget commonBottomError({required String text}) {
  return text.isEmpty
      ? const SizedBox.shrink()
      : Container(
          padding: const EdgeInsets.all(11),
          color: ColorName.redFf3,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info,
                color: Colors.white,
                size: 13,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  text,
                  style: AppTextStyle.w500s11(ColorName.whiteFff),
                ),
              ),
            ],
          ),
        );
}

@swidget
Widget commonBottomButton({
  required String text,
  Color fillColor = ColorName.primaryColor,
  double pressedOpacity = 0.4,
  Function()? onPressed,
  BaseState? state,
}) {
  final textWidget = Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Text(
      text,
      style: AppTextStyle.w600s15(ColorName.whiteFff),
    ),
  );
  return SizedBox(
    height: 80,
    child: CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      pressedOpacity: pressedOpacity,
      child: Container(
        alignment: Alignment.center,
        color: fillColor,
        child: state != null
            ? state.widget(
                onEmpty: textWidget,
                onLoading: const Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 14.0),
                    child: CupertinoActivityIndicator(color: Colors.white),
                  ),
                ),
              )
            : textWidget,
      ),
    ),
  );
}

@swidget
Widget commonMenu(
  List<Map<int, Widget>> items, {
  int totalNotification = 0,
  double top = 0,
  double? bottom,
  double? right,
  double? left,
  double height = 50,
  double width = 50,
  int duration = 200,
  double space = 5,
  Color color = ColorName.whiteFff,
  double radius = 0,
}) {
  //
  Rx<bool> startAnimation = false.obs;
  return Obx(
    () {
      return Stack(
        children: [
          for (var index = 0; index < items.length; index++)
            Stack(
              children: [
                AnimatedPositioned(
                  duration: Duration(milliseconds: duration),
                  top: startAnimation.value ? ((space + height) * (index + 1) + top) : top,
                  left: left,
                  bottom: bottom,
                  right: right,
                  curve: Curves.easeInCubic,
                  child: Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.all(
                        Radius.circular(radius),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0.0, 4.0),
                          blurRadius: 4,
                          color: ColorName.black000.withOpacity(0.25),
                        ),
                      ],
                    ),
                    child: Center(child: items[index].values.first),
                  ),
                ),
                if (items[index].keys.first > 0)
                  AnimatedPositioned(
                    duration: Duration(milliseconds: duration),
                    top: startAnimation.value ? ((space + height) * (index + 1) + top) : top,
                    left: left,
                    bottom: bottom,
                    right: right,
                    curve: Curves.easeInCubic,
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorName.primaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 15,
                        minHeight: 15,
                      ),
                      child: Center(
                        child: Text(
                          '${items[index].keys.first}',
                          style: AppTextStyle.w700s8(ColorName.whiteFff),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          Positioned(
            top: top,
            left: left,
            bottom: bottom,
            right: right,
            child: GestureDetector(
              onTap: () {
                startAnimation.value = !startAnimation.value;
              },
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.all(
                    Radius.circular(radius),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0.0, 4.0),
                      blurRadius: 4,
                      color: ColorName.black000.withOpacity(0.25),
                    ),
                  ],
                ),
                child: Center(
                  child: startAnimation.value
                      ? Assets.images.menuIsOpenIcon.image(height: 18, width: 18)
                      : Assets.images.menuIcon.image(height: 18, width: 18),
                ),
              ),
            ),
          ),
          if (totalNotification > 0 && !startAnimation.value)
            Positioned(
              top: top,
              left: left,
              bottom: bottom,
              right: right,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorName.primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                constraints: const BoxConstraints(
                  minWidth: 15,
                  minHeight: 15,
                ),
                child: Center(
                  child: Text(
                    '$totalNotification',
                    style: AppTextStyle.w700s8(ColorName.whiteFff),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
        ],
      );
    },
  );
}

@swidget
Widget commonSearchBar({
  double height = 50,
  Function()? onPressed,
  Function()? leadingPressed,
  Function()? trailingPressed,
  Widget leading = const SizedBox.shrink(),
  Widget trailing = const SizedBox.shrink(),
  Widget title = const SizedBox.shrink(),
  double? leftPadding = 10,
  double? rightPadding = 10,
  double? titlePadding = 10,
}) {
  return CupertinoButton(
    pressedOpacity: 0.6,
    padding: EdgeInsets.zero,
    onPressed: onPressed,
    child: Container(
      height: height,
      decoration: BoxDecoration(
        color: ColorName.whiteFff,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 4,
            color: ColorName.black000.withOpacity(0.25),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(width: leftPadding),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: leadingPressed,
            child: leading,
          ),
          SizedBox(width: titlePadding),
          Expanded(child: title),
          SizedBox(width: titlePadding),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: trailingPressed,
            child: trailing,
          ),
          SizedBox(width: rightPadding),
        ],
      ),
    ),
  );
}

@swidget
Widget radioButonGroup(List<String> data,
    {String? title, Widget? icon, Function(int)? callBack, int? curentIndex, dynamic money = 0, bool? isLoading}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          const SizedBox(width: 5),
          icon ?? const SizedBox.shrink(),
          const SizedBox(width: 5),
          Text(
            title ?? "",
            style: AppTextStyle.w500s17(ColorName.black000),
          ),
          const Spacer(),
          if (isLoading ?? false)
            const LoadingWidget(
              color: ColorName.primaryColor,
            ),
          if (!(isLoading ?? false))
            Text(
              ' + ',
              textAlign: TextAlign.center,
              style: AppTextStyle.w700s16(ColorName.primaryColor),
            ),
          if (!(isLoading ?? false))
            Text(
              NumberFormat('#,##0')
                  .format(
                    money ?? 0,
                  )
                  .replaceAll(',', '.'),
              textAlign: TextAlign.center,
              style: AppTextStyle.w700s16(ColorName.green459),
            ),
          if (!(isLoading ?? false))
            Text(
              ' đ',
              textAlign: TextAlign.center,
              style: AppTextStyle.w600s10(ColorName.redFf0),
            ),
        ],
      ),
      const SizedBox(height: 5),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: ColorName.black000.withOpacity(0.3),
              offset: const Offset(5, 5),
              blurRadius: 10,
            ),
          ],
          color: ColorName.whiteFff,
        ),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                curentIndex = index;
                if (callBack != null) {
                  callBack(index);
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    curentIndex == index
                        ? Assets.images.radioButtonChecked.image(width: 20, color: ColorName.primaryColor)
                        : Assets.images.radioButtonUncheck.image(width: 20, color: ColorName.primaryColor),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        data[index],
                        style: AppTextStyle.w600s15(ColorName.black000),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}

@swidget
Widget statusOrderWidget(int status) {
  return Container(
    height: 100,
    decoration: BoxDecoration(
      border: Border.all(width: 0.5, color: ColorName.grayC7c),
      color: ColorName.grayF8f,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Assets.images.orderStatus.image(
          width: 25,
          color: status == 4 ? ColorName.redEb5 : ColorName.green5d9,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            "------",
            style: AppTextStyle.w600s20(
              status == 4
                  ? ColorName.redEb5
                  : status > 1
                      ? ColorName.green5d9
                      : ColorName.black000,
            ),
          ),
        ),
        Assets.images.deliveryStatus.image(
          width: 25,
          color: status == 4
              ? ColorName.redEb5
              : status > 1
                  ? ColorName.green5d9
                  : ColorName.black000,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            "------",
            style: AppTextStyle.w600s20(
              status == 4
                  ? ColorName.redEb5
                  : status > 2
                      ? ColorName.green5d9
                      : ColorName.black000,
            ),
          ),
        ),
        Assets.images.shippingStatus.image(
          width: 25,
          color: status == 4
              ? ColorName.redEb5
              : status > 2
                  ? ColorName.green5d9
                  : ColorName.black000,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            "------",
            style: AppTextStyle.w600s20(
              status == 4
                  ? ColorName.redEb5
                  : status > 3
                      ? ColorName.green5d9
                      : ColorName.black000,
            ),
          ),
        ),
        Assets.images.checkedStatus.image(
          width: 25,
          color: status == 4
              ? ColorName.redEb5
              : status > 3
                  ? ColorName.green5d9
                  : ColorName.black000,
        ),
      ],
    ),
  );
}
