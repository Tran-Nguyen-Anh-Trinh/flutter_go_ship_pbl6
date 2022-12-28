import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_app_bar.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/setting/setting_controller.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../base/presentation/widgets/common.dart';
import '../../../../../utils/extension/form_builder.dart';
import '../../../../../utils/services/Models/infor_user.dart';

class SettingPage extends BaseWidget<SettingController> {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget onBuild(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: const Text('Cài đặt'),
      ),
      backgroundColor: ColorName.grayF4f,
      body: Obx(
        () => IgnorePointer(
          ignoring: controller.isLoading.value,
          child: SmartRefresher(
            enablePullDown: true,
            controller: controller.refreshController,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoading,
            header: const WaterDropMaterialHeader(
              backgroundColor: ColorName.blue007,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    color: ColorName.grayF4f,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(35),
                          child: Obx(
                            () => CachedNetworkImage(
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                              imageUrl: (controller.accountInfo.value.role == 1)
                                  ? controller.customerInfo.value.avatarUrl ?? ''
                                  : controller.shipperInfo.value.avatarUrl ?? '',
                              placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Assets.images.profileIcon.image(height: 60, width: 60),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Obx(
                            () => Text(
                              (controller.accountInfo.value.role == 1)
                                  ? controller.customerInfo.value.name ?? ''
                                  : controller.shipperInfo.value.name ?? '',
                              style: AppTextStyle.w600s16(ColorName.black000),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  settingItem(
                    title: AppConfig.accountInfo.phoneNumber,
                    leading: Assets.images.phoneIcon1.image(scale: 3),
                    onPressed: N.toProfile,
                  ),
                  settingItem(
                    title: "Đổi mật khẩu",
                    leading: Assets.images.keyIcon.image(scale: 3),
                    onPressed: N.toChangePassword,
                  ),
                  settingItem(
                    title: "Đăng xuất",
                    leading: Assets.images.logOutIcon.image(scale: 3),
                    onPressed: controller.logout,
                  ),
                  Container(
                    color: ColorName.grayF4f,
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
                          "Tài khoản của tôi",
                          style: AppTextStyle.w600s15(ColorName.black000),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  if (controller.accountInfo.value.role == 1)
                    settingItem(
                      title: "Địa chỉ đã lưu",
                      leading: Assets.images.addressIcon.image(scale: 3),
                      onPressed: () {
                        N.toAddAddress(isSetting: true);
                      },
                    ),
                  if (controller.accountInfo.value.role == 2 && controller.shipperInfo.value.account != null)
                    settingItem(
                      title: "Đánh giá từ người dùng",
                      leading: Assets.images.phoneIcon.image(width: 22, color: ColorName.gray828),
                      onPressed: () {
                        N.toShipperDetail(shipperID: '${controller.shipperInfo.value.account!}');
                      },
                    ),
                  settingItem(
                    title: "Khoảng cách hiển thị",
                    leading: Assets.images.distanceIcon.image(scale: 3),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Obx(
                          () => SelectDistance(
                            value:
                                '${controller.accountInfo.value.role == 1 ? controller.customerInfo.value.distanceView ?? 10 : controller.shipperInfo.value.distanceReceive ?? 10} km',
                            callBack: (value) {
                              controller.onSaveDistanceView(value);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    color: ColorName.grayF4f,
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
                          "Tổng quát",
                          style: AppTextStyle.w600s15(ColorName.black000),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  settingItem(
                    title: "Trung tâm trợ giúp",
                    leading: Assets.images.supportIcon.image(scale: 3),
                    onPressed: () {
                      N.toChatDetail(
                        input: InforUser(phone: '0343440209', name: 'Admin'),
                      );
                    },
                  ),
                  settingItem(
                    title: "Giới thiệu",
                    leading: Assets.images.introIcon.image(scale: 3),
                    onPressed: () {
                      launchUrlString(
                        'http://167.71.197.115:8000/admin/login/?next=/admin/',
                        mode: LaunchMode.externalApplication,
                      );
                    },
                  ),
                  settingItem(
                    title: "Cài đặt",
                    leading: Assets.images.settingIcon.image(scale: 3),
                    onPressed: () {
                      N.toSettingSystem();
                    },
                  ),
                  if (controller.accountInfo.value.role == 1)
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: ColorName.grayF4f,
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
                                "Trở thành đối tác của Go Ship",
                                style: AppTextStyle.w600s15(ColorName.black000),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        settingItem(
                          title: "Lái xe cùng Go Ship",
                          leading: Assets.images.bikeIcon.image(scale: 3),
                          onPressed: () {
                            N.toBecomeShipper();
                          },
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectDistance extends StatelessWidget {
  SelectDistance({super.key, this.callBack, this.value});

  String? value;

  String valueChange = '';

  Function(String)? callBack;

  @override
  Widget build(BuildContext context) {
    valueChange = value ?? '10 km';
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            12.0,
          ),
        ),
      ),
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        'Khoảng cách hiển thị',
        style: AppTextStyle.w600s17(ColorName.black000),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Khoảng cách tìm kiếm và hiển thị tài xế quanh khu vực của bạn',
              style: AppTextStyle.w400s13(ColorName.black000),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            color: ColorName.whiteFff,
            child: DropdownButtonFormField2(
              value: value,
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
                'Chọn khoảng cách',
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
              items: ['1 km', '2 km', '3 km', '4 km', '5 km', '6 km', '7 km', '8 km', '9 km', '10 km']
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
              validator: (value) {
                if (value == null) {
                  return 'Vui lòng chọn giới tính.';
                }
              },
              onChanged: (value) {
                valueChange = value.toString();
              },
            ),
          ),
          const SizedBox(height: 15),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 0.5, color: ColorName.grayBdb),
                      right: BorderSide(width: 0.25, color: ColorName.grayBdb),
                    ),
                  ),
                  child: CupertinoButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Hủy',
                      style: AppTextStyle.w400s17(ColorName.blue007),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 0.5, color: ColorName.grayBdb),
                      left: BorderSide(width: 0.25, color: ColorName.grayBdb),
                    ),
                  ),
                  child: CupertinoButton(
                    onPressed: () => {
                      callBack?.call(valueChange),
                      Navigator.pop(context),
                    },
                    child: Text(
                      'Xác nhận',
                      style: AppTextStyle.w600s17(ColorName.blue007),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SetMessagesDefault extends StatefulWidget {
  SetMessagesDefault({super.key, this.value, this.callback});
  String? value;
  Function(String)? callback;

  @override
  State<SetMessagesDefault> createState() => _SetMessagesDefaultState();
}

class _SetMessagesDefaultState extends State<SetMessagesDefault> {
  final formKey = GlobalKey<FormBuilderState>();

  final noteTextEditingController = TextEditingController();

  @override
  void dispose() {
    noteTextEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    noteTextEditingController.text = widget.value ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            12.0,
          ),
        ),
      ),
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        'Tin nhắn mặc định',
        style: AppTextStyle.w600s17(ColorName.black000),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Nhập tin nhắn mặc định để trả lời khi có tin nhắn mới từ người lạ',
              style: AppTextStyle.w400s13(ColorName.black000),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CommonTextField(
              formKey: formKey,
              height: 108,
              maxLines: 10,
              type: FormFieldType.messagesDefault,
              textInputAction: TextInputAction.newline,
              controller: noteTextEditingController,
              // onTap: controller.hideErrorMessage,
              onChanged: (_) {
                // controller.updateLoginButtonState();
              },
              onSubmitted: (p0) {},
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 0.5, color: ColorName.grayBdb),
                      right: BorderSide(width: 0.25, color: ColorName.grayBdb),
                    ),
                  ),
                  child: CupertinoButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Hủy',
                      style: AppTextStyle.w400s17(ColorName.blue007),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 0.5, color: ColorName.grayBdb),
                      left: BorderSide(width: 0.25, color: ColorName.grayBdb),
                    ),
                  ),
                  child: CupertinoButton(
                    onPressed: () {
                      final text = noteTextEditingController.text.trim();
                      if (text.isNotEmpty) {
                        widget.callback?.call(text);
                      }
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Xác nhận',
                      style: AppTextStyle.w600s17(ColorName.blue007),
                    ),
                  ),
                ),
              ),
            ],
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
        color: ColorName.whiteFff,
        border: Border(
          bottom: const BorderSide(width: 1, color: ColorName.grayBdb),
          top: topBorder ? const BorderSide(width: 1, color: ColorName.grayBdb) : BorderSide.none,
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
