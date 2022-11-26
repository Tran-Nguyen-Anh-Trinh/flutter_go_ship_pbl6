import 'package:flutter/cupertino.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_app_bar.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/setting/setting_controller.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';

class SettingPage extends BaseWidget<SettingController> {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget onBuild(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: const Text('Cài đặt'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Text(
                    "Tài khoản",
                    style: AppTextStyle.w600s15(ColorName.black000),
                  ),
                ),
                settingItem(
                  topBorder: true,
                  title: "Chỉnh sửa thông tin cá nhân",
                  leading: const Icon(
                    Icons.edit_note_outlined,
                    color: ColorName.gray828,
                  ),
                  onPressed: () {},
                ),
                settingItem(
                  title: "Đổi mật khẩu",
                  leading: const Icon(
                    Icons.key_outlined,
                    color: ColorName.gray828,
                  ),
                  onPressed: () {},
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Text(
                    "Đăng xuất",
                    style: AppTextStyle.w600s15(ColorName.black000),
                  ),
                ),
                settingItem(
                  title: "Đăng xuất",
                  leading: const Icon(
                    Icons.logout_outlined,
                    color: ColorName.gray828,
                  ),
                  topBorder: true,
                  onPressed: controller.logout,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget settingItem({
  String? title,
  Widget? leading,
  required Function() onPressed,
  bool topBorder = false,
}) {
  return CupertinoButton(
    padding: EdgeInsets.zero,
    onPressed: onPressed,
    child: Container(
      alignment: Alignment.center,
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: const BorderSide(width: 0.5, color: ColorName.grayBdb),
          top: topBorder ? const BorderSide(width: 0.5, color: ColorName.grayBdb) : BorderSide.none,
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          leading ?? const SizedBox.shrink(),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title ?? "",
              style: AppTextStyle.w400s15(ColorName.black000),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_right_outlined,
            color: ColorName.gray838,
          ),
          const SizedBox(width: 16),
        ],
      ),
    ),
  );
}
