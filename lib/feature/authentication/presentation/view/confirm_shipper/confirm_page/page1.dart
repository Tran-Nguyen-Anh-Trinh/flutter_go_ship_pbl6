import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/common.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/presentation/view/confirm_shipper/confirm_shipper_page.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/extension/form_builder.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

extension ConfirmShipperPage1 on ConfirmShipperPage {
  Widget confirmShipper1(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScrren = MediaQuery.of(context).size.height;

    final kGradientBoxDecoration = BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.3, 0.9],
        colors: [ColorName.whiteFff, ColorName.primaryColor],
      ),
      borderRadius: BorderRadius.circular(82),
    );

    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        if (!isKeyboardVisible) {
          controller.isKeyBoardOn.value = false;
        } else {
          controller.isKeyBoardOn.value = true;
        }

        return GestureDetector(
          onTap: controller.hideKeyboard,
          child: Obx(
            () => IgnorePointer(
              ignoring: controller.ignoringPointer.value,
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Stack(
                  children: [
                    Assets.images.profileBanner.image(width: widthScreen),
                    Positioned(
                      right: 20,
                      top: MediaQuery.of(context).viewPadding.top + 10,
                      child: Text(
                        "1/3",
                        style: AppTextStyle.w600s20(ColorName.whiteFff),
                      ),
                    ),
                    Positioned(
                      top: widthScreen * (196 / 375) - 41,
                      right: 40,
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: (() {}),
                        child: Container(
                          height: 82,
                          width: 82,
                          decoration: kGradientBoxDecoration,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              height: 82,
                              width: 82,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(82),
                              ),
                              child: controller.shipper.value.gender == 0
                                  ? Assets.images.profileIcon.image(
                                      width: 82,
                                      height: 82,
                                      fit: BoxFit.cover,
                                    )
                                  : controller.shipper.value.gender == 1
                                      ? Assets.images.profileMaleIcon.image(
                                          width: 82,
                                          height: 82,
                                          fit: BoxFit.cover,
                                        )
                                      : Assets.images.profileFemaleIcon.image(
                                          width: 82,
                                          height: 82,
                                          fit: BoxFit.cover,
                                        ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: widthScreen * (196 / 375) + 61,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              flex: controller.isKeyBoardOn.value ? 1 : 20,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4, left: 16, right: 16),
                                child: FormBuilder(
                                  key: controller.formKey,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(height: 20),
                                        CommonTextField(
                                          formKey: controller.formKey,
                                          type: FormFieldType.phone,
                                          maxLength: 13,
                                          controller: controller.phoneTextEditingController,
                                          isEnable: false,
                                          onTap: controller.hideErrorMessage,
                                          onChanged: (_) {
                                            controller.updateLoginButtonState();
                                          },
                                        ),
                                        const SizedBox(height: 2),
                                        CommonTextField(
                                          formKey: controller.formKey,
                                          type: FormFieldType.name,
                                          maxLength: 35,
                                          controller: controller.nameTextEditingController,
                                          onTap: controller.hideErrorMessage,
                                          onChanged: (_) {
                                            controller.updateLoginButtonState();
                                          },
                                        ),
                                        const SizedBox(height: 2),
                                        CommonDropDown(
                                          title: "Giới tính",
                                          value: controller.shipper.value.gender == 0
                                              ? null
                                              : controller.shipper.value.gender == 1
                                                  ? "Nam"
                                                  : "Nữ",
                                          onPressed: (() {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                  height: 250,
                                                  color: ColorName.whiteFaf,
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      CupertinoButton(
                                                        padding: EdgeInsets.zero,
                                                        onPressed: () {
                                                          controller.shipper.value.gender = 1;
                                                          controller.shipper.refresh();
                                                          Navigator.pop(context);
                                                        },
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          height: 50,
                                                          width: double.infinity,
                                                          decoration: const BoxDecoration(
                                                            border: Border(
                                                              bottom: BorderSide(width: 0.5, color: ColorName.grayBdb),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            "Nam",
                                                            style: AppTextStyle.w400s15(ColorName.black000),
                                                          ),
                                                        ),
                                                      ),
                                                      CupertinoButton(
                                                        padding: EdgeInsets.zero,
                                                        onPressed: () {
                                                          controller.shipper.value.gender = 2;
                                                          controller.shipper.refresh();
                                                          Navigator.pop(context);
                                                        },
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          height: 50,
                                                          width: double.infinity,
                                                          decoration: const BoxDecoration(
                                                            border: Border(
                                                              bottom: BorderSide(width: 0.5, color: ColorName.grayBdb),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            "Nữ",
                                                            style: AppTextStyle.w400s15(ColorName.black000),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          }),
                                        ),
                                        const SizedBox(height: 2),
                                        CommonTextField(
                                          formKey: controller.formKey,
                                          height: 108,
                                          maxLines: 10,
                                          type: FormFieldType.memo,
                                          textInputAction: TextInputAction.newline,
                                          controller: controller.noteTextEditingController,
                                          onTap: controller.hideErrorMessage,
                                          onChanged: (_) {
                                            controller.updateLoginButtonState();
                                          },
                                          onSubmitted: (p0) {},
                                        ),
                                        const SizedBox(height: 5),
                                        CupertinoButton(
                                          padding: EdgeInsets.zero,
                                          alignment: Alignment.centerRight,
                                          onPressed: controller.onTapAddAddress,
                                          child: Container(
                                            width: 55,
                                            height: 55,
                                            decoration: BoxDecoration(
                                              color: ColorName.whiteFaf,
                                              borderRadius: BorderRadius.circular(55),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: ColorName.black000.withOpacity(0.25),
                                                  offset: const Offset(0, 4),
                                                  blurRadius: 4,
                                                ),
                                              ],
                                            ),
                                            child: Center(
                                              child: Assets.images.addAddressIcon.image(width: 25),
                                            ),
                                          ),
                                        ),
                                        if (controller.addressNull.value)
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right: 25),
                                                child: Assets.images.upArrowIcon.image(width: 50),
                                              ),
                                              Text(
                                                'Vui lòng lựa chọn vị trí chính xác trên bản đồ',
                                                style: AppTextStyle.w400s13(ColorName.redEb5),
                                              )
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(flex: 1),
                            Obx(
                              () => CommonBottomError(text: controller.errorMessage.value),
                            ),
                            Obx(
                              () => CommonBottomButton(
                                text: 'Tiếp tục',
                                onPressed: () => controller.onNextPage1(context),
                                pressedOpacity: controller.isDisableButton.value ? 1 : 0.4,
                                fillColor:
                                    controller.isDisableButton.value ? ColorName.gray838 : ColorName.primaryColor,
                                state: controller.confirmState,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
