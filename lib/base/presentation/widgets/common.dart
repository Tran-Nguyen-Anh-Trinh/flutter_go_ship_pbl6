import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_go_ship_pbl6/utils/extension/form_builder.dart';
import 'package:flutter_go_ship_pbl6/base/domain/base_state.dart';
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

@swidget
Widget commonTextField(
  BuildContext textFieldContext, {
  GlobalKey<FormBuilderState>? formKey,
  required FormFieldType type,
  bool obscureText = false,
  bool isEnable = true,
  int? maxLines = 1,
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
                errorMaxLines: 2,
                isDense: true,
                labelText: type.labelText,
                labelStyle: const TextStyle(fontSize: 11),
                alignLabelWithHint: true,
                filled: true,
                fillColor: hasFocus ? ColorName.whiteFff : ColorName.grayF8f,
                hintText: type.hintText,
                hintStyle: AppTextStyle.w400s13(ColorName.grayC7c),
                errorStyle: AppTextStyle.w400s13(ColorName.redFf3, height: 1),
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
Widget commonButton({
  required Widget child,
  double? width,
  double height = 44,
  Function()? onPressed,
  Color fillColor = ColorName.green4c8,
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
