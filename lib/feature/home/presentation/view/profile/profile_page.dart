import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import '../../../../../base/presentation/base_widget.dart';
import '../../../../../base/presentation/widgets/common.dart';
import '../../../../../utils/config/app_config.dart';
import '../../../../../utils/extension/form_builder.dart';
import '../../../../../utils/gen/assets.gen.dart';
import '../../../../../utils/gen/colors.gen.dart';
import '../../controller/profile/profile_controller.dart';
import '../setting/setting_page.dart';

class ProfilePage extends BaseWidget<ProfileController> {
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget onBuild(BuildContext context) {
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
    return GestureDetector(
      onTap: controller.hideKeyboard,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Cập nhật thông tin cá nhân"),
          backgroundColor: ColorName.whiteFff,
          foregroundColor: ColorName.primaryColor,
          centerTitle: true,
          titleTextStyle: AppTextStyle.w600s13(ColorName.black333),
          elevation: 3,
          leading: const CommonBackButton(),
          actions: [
            CupertinoButton(
              onPressed: () {
                controller.onTapSave();
              },
              child: Text(
                'Lưu',
                style: AppTextStyle.w600s13(ColorName.blue007),
              ),
            ),
          ],
          leadingWidth: 100,
          shadowColor: Colors.black26,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: const Color.fromARGB(255, 236, 236, 236),
          child: Stack(
            children: [
              Assets.images.profileBanner.image(width: widthScreen),
              Positioned(
                top: widthScreen * (196 / 375) - 41,
                right: 40,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    controller.getPhoto();
                  },
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
                        child: Obx(
                          () => controller.imagePath.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(35),
                                  child: Image.file(
                                    File(controller.imagePath.value),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(35),
                                  child: CachedNetworkImage(
                                    height: 70,
                                    width: 70,
                                    fit: BoxFit.cover,
                                    imageUrl: controller.accountInfo.role == 1
                                        ? AppConfig.customerInfo.avatarUrl ?? ''
                                        : AppConfig.shipperInfo.avatarUrl ?? '',
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => Assets
                                        .images.profileIcon
                                        .image(height: 70, width: 70),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: widthScreen * (196 / 375) + 61,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 4, left: 16, right: 16),
                      child: FormBuilder(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 20),
                            CommonTextField(
                              formKey: controller.formKey,
                              type: FormFieldType.name,
                              maxLength: 35,
                              controller: controller.nameTextEditingController,
                              isEnable: controller.accountInfo.role != 2,
                              // onTap: controller.hideErrorMessage,
                              onChanged: (_) {
                                // controller.updateLoginButtonState();
                              },
                            ),
                            CommonTextField(
                              isEnable: false,
                              formKey: controller.formKey,
                              type: FormFieldType.phone,
                              maxLength: 13,
                              controller: controller.phoneTextEditingController,
                              // onTap: controller.hideErrorMessage,
                              onChanged: (_) {
                                // controller.updateLoginButtonState();
                              },
                            ),
                            Container(
                              color: ColorName.whiteFff,
                              child: DropdownButtonFormField2(
                                value: controller.dropdownValue,
                                isExpanded: false,
                                decoration: InputDecoration(
                                  fillColor: ColorName.whiteFff,
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: ColorName.gray838,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: ColorName.blue007,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                hint: Text(
                                  'Giới tính',
                                  style: AppTextStyle.w400s13(
                                    ColorName.gray838,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: ColorName.gray838,
                                ),
                                iconSize: 30,
                                buttonHeight: 50,
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: ColorName.gray838,
                                    width: 1,
                                  ),
                                ),
                                items: controller.items
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: controller.accountInfo.role == 1
                                    ? (value) {
                                        controller.dropdownValue =
                                            value.toString();
                                      }
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ),
                    if (controller.accountInfo.role == 1)
                      Container(
                        color: const Color.fromARGB(255, 236, 236, 236),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                              width: Get.width,
                            ),
                            Text(
                              "Hồ sơ",
                              style: AppTextStyle.w600s15(ColorName.black000),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    if (controller.accountInfo.role == 1)
                      settingItem(
                        title: "Hồ sơ doanh nghiệp",
                        topBorder: true,
                        leading: Assets.images.applicationIcon.image(scale: 3),
                        onPressed: () {},
                      ),
                  ],
                ),
              ),
              Obx(() => (controller.isLoading.value)
                  ? Positioned.fill(
                      child: Container(
                        color: ColorName.black000.withOpacity(0.6),
                        child: const LoadingWidget(
                          color: ColorName.whiteFff,
                        ),
                      ),
                    )
                  : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }
}
