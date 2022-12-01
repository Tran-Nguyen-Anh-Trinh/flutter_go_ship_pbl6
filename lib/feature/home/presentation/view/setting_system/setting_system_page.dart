import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../base/presentation/base_app_bar.dart';
import '../../../../../utils/config/app_navigation.dart';
import '../../../../../utils/config/app_text_style.dart';
import '../../../../../utils/gen/assets.gen.dart';
import '../../../../../utils/gen/colors.gen.dart';
import '../../system_system/setting_system_controller.dart';
import '../setting/setting_page.dart';

class SettingSystemPage extends GetView<SettingSystemController> {
  const SettingSystemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: const Text('Cài đặt'),
      ),
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              color: const Color.fromARGB(255, 236, 236, 236),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                    width: Get.width,
                  ),
                  Text(
                    "Quyền riêng tư",
                    style: AppTextStyle.w600s15(ColorName.black000),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            SettingItem(
              title: "Thông báo đẩy",
              leading: Assets.images.bellIcon.image(scale: 3),
              onPressed: () {},
            ),
            SettingItem(
              title: "Vị trí",
              leading: Assets.images.exploreIcon.image(scale: 3),
              onPressed: () {},
            ),
            SettingItem(
              title: "Máy ảnh",
              leading: Assets.images.cameraIcon1.image(scale: 3),
              onPressed: () {},
            ),
            Container(
              color: const Color.fromARGB(255, 236, 236, 236),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                    width: Get.width,
                  ),
                  Text(
                    "Goship Chat",
                    style: AppTextStyle.w600s15(ColorName.black000),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            settingItem(
              title: "Quản lý trả lời nhanh",
              leading: Assets.images.messageIcon.image(scale: 3),
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: ((context) {
                    return SetMessagesDefault(
                        value: controller.defaultMessages,
                        callback: (text) {
                          controller.setDefaultMessages(text);
                        });
                  }),
                );
              },
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: const Color.fromARGB(255, 236, 236, 236),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                        width: Get.width,
                      ),
                      Text(
                        "Quản lý tài khoản",
                        style: AppTextStyle.w600s15(ColorName.black000),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                settingItem(
                  title: "Xóa tài khoản",
                  leading: Assets.images.binIcon.image(scale: 3),
                  onPressed: () {
                    showOkCancelAlertDialog(
                      fullyCapitalizedForMaterial: false,
                      okLabel: 'Xác nhận',
                      cancelLabel: 'Hủy',
                      context: context,
                      title: 'Xóa tài khoản',
                      message:
                          'Sau khi xác nhận tài khoản của bạn sẽ bị loại bỏ hoàn toàn khỏi hệ của chúng tôi và không thể đăng nhập lại bằng tài khoản này. Bạn chắc chắn chứ?',
                    ).then((value) {
                      if (value == OkCancelResult.ok) {
                        controller.backWelcomePage();
                      }
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class SettingItem extends StatefulWidget {
  SettingItem({
    super.key,
    this.title,
    this.leading,
    required this.onPressed,
    this.topBorder = false,
  });

  String? title;
  Widget? leading;
  Function() onPressed;
  bool topBorder;

  bool stateSwitch = true;

  @override
  State<SettingItem> createState() => _SettingItemState();
}

class _SettingItemState extends State<SettingItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorName.whiteFff,
        border: Border(
          bottom: const BorderSide(width: 1, color: ColorName.grayBdb),
          top: widget.topBorder
              ? const BorderSide(width: 1, color: ColorName.grayBdb)
              : BorderSide.none,
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          widget.leading ?? const SizedBox.shrink(),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              widget.title ?? "",
              style: AppTextStyle.w400s15(ColorName.black000),
            ),
          ),
          Transform.scale(
            scale: 0.6,
            child: CupertinoSwitch(
              value: widget.stateSwitch,
              onChanged: (value) {
                setState(() {
                  widget.stateSwitch = !widget.stateSwitch;
                });
              },
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
