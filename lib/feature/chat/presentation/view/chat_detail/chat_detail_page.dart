import 'package:flutter/cupertino.dart';
import 'package:flutter_go_ship_pbl6/feature/chat/presentation/view/chat_detail/widgets/widget.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../base/presentation/base_app_bar.dart';
import '../../../../../utils/config/app_text_style.dart';
import '../../../../../utils/gen/colors.gen.dart';
import '../../controller/chat_detail/chat_detail_controller.dart';

class ChatDetailPage extends GetView<ChatDetailController> {
  ChatDetailPage({Key? key}) : super(key: key);

  final inputBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(12));

  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (focusNode.hasFocus) {
      controller.scrollToBottom();
    }
    return GestureDetector(
      onTap: controller.hideKeyboard,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BaseAppBar(
          title: Text(controller.userReceive.name ?? ''),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 7),
              child: CupertinoButton(
                child: Assets.images.callIcon.image(scale: 3),
                onPressed: () {
                  launchUrl(Uri.parse('tel:${controller.userReceive.phone}'));
                },
              ),
            ),
          ],
        ),
        body: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  color: ColorName.whiteFaf,
                  child: Obx(
                    () => Stack(
                      children: [
                        controller.isLoading.value
                            ? const Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: CupertinoActivityIndicator(
                                      color: ColorName.black000),
                                ),
                              )
                            : const SizedBox.shrink(),
                        ListView.separated(
                          reverse: true,
                          controller: controller.scrollController,
                          physics: const ClampingScrollPhysics(),
                          padding: const EdgeInsets.all(20),
                          itemCount: controller.messagesList.length,
                          itemBuilder: ((context, index) {
                            return controller
                                        .messagesList[
                                            controller.messagesList.length -
                                                1 -
                                                index]
                                        .senderPhone ==
                                    AppConfig.accountModel.phoneNumber
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (controller
                                              .messagesList[controller
                                                      .messagesList.length -
                                                  1 -
                                                  index]
                                              .image !=
                                          null)
                                        if (controller
                                            .messagesList[
                                                controller.messagesList.length -
                                                    1 -
                                                    index]
                                            .image!
                                            .isNotEmpty)
                                          SendImageItems(
                                            width: width * 2 / 3,
                                            urls: controller
                                                .messagesList[controller
                                                        .messagesList.length -
                                                    1 -
                                                    index]
                                                .image!
                                                .split('##'),
                                          ),
                                      if (controller
                                              .messagesList[controller
                                                      .messagesList.length -
                                                  1 -
                                                  index]
                                              .messages !=
                                          null)
                                        if (controller
                                            .messagesList[
                                                controller.messagesList.length -
                                                    1 -
                                                    index]
                                            .messages!
                                            .isNotEmpty)
                                          SentItem(
                                            width: width,
                                            content: controller
                                                .messagesList[controller
                                                        .messagesList.length -
                                                    1 -
                                                    index]
                                                .messages!,
                                            dateTime: handleTime(controller
                                                .messagesList[controller
                                                        .messagesList.length -
                                                    1 -
                                                    index]
                                                .dateTime),
                                          ),
                                    ],
                                  )
                                : Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (controller
                                              .messagesList[controller
                                                      .messagesList.length -
                                                  1 -
                                                  index]
                                              .image !=
                                          null)
                                        if (controller
                                            .messagesList[
                                                controller.messagesList.length -
                                                    1 -
                                                    index]
                                            .image!
                                            .isNotEmpty)
                                          ReceiveImageItems(
                                            width: width * 2 / 3,
                                            urls: controller
                                                .messagesList[controller
                                                        .messagesList.length -
                                                    1 -
                                                    index]
                                                .image!
                                                .split('##'),
                                          ),
                                      if (controller
                                              .messagesList[controller
                                                      .messagesList.length -
                                                  1 -
                                                  index]
                                              .messages !=
                                          null)
                                        if (controller
                                            .messagesList[
                                                controller.messagesList.length -
                                                    1 -
                                                    index]
                                            .messages!
                                            .isNotEmpty)
                                          ReceiveItem(
                                            width: width,
                                            content: controller
                                                .messagesList[controller
                                                        .messagesList.length -
                                                    1 -
                                                    index]
                                                .messages!,
                                            dateTime: handleTime(controller
                                                .messagesList[controller
                                                        .messagesList.length -
                                                    1 -
                                                    index]
                                                .dateTime),
                                          ),
                                    ],
                                  );
                          }),
                          separatorBuilder: (context, index) {
                            if (calculateTime(
                                controller
                                    .messagesList[
                                        controller.messagesList.length -
                                            1 -
                                            index -
                                            1]
                                    .dateTime,
                                controller
                                    .messagesList[
                                        controller.messagesList.length -
                                            1 -
                                            index]
                                    .dateTime)) {
                              if (controller
                                      .messagesList[
                                          controller.messagesList.length -
                                              1 -
                                              index -
                                              1]
                                      .senderPhone ==
                                  controller
                                      .messagesList[
                                          controller.messagesList.length -
                                              1 -
                                              index]
                                      .senderPhone) {
                                return const SizedBox.shrink();
                              }
                            }
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 50),
                                Text(
                                  handleTime(controller
                                      .messagesList[
                                          controller.messagesList.length -
                                              1 -
                                              index]
                                      .dateTime),
                                  style:
                                      AppTextStyle.w400s12(ColorName.gray838),
                                  maxLines: null,
                                ),
                                const SizedBox(height: 10),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Obx(
                () => Container(
                  color: ColorName.whiteFff,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      controller.isHide.value
                          ? const SizedBox.shrink()
                          : SizedBox(
                              height: 90,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.imageList.length,
                                itemBuilder: (context, index) => ImageSelect(
                                  path: controller.imageList[index],
                                  onPressed: () {
                                    controller.imageList.removeAt(index);
                                    if (controller.imageList.isEmpty) {
                                      controller.isHide.value = true;
                                    }
                                  },
                                ),
                              ),
                            ),
                      Row(
                        children: [
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              showBottomSheet(context, controller);
                            },
                            child: Assets.images.cameraIcon.image(scale: 3),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextField(
                              minLines: 1,
                              maxLines: 5,
                              focusNode: focusNode,
                              controller:
                                  controller.messagesTextEditingController,
                              cursorColor: ColorName.blue007,
                              decoration: InputDecoration(
                                fillColor: ColorName.grayD2d,
                                filled: true,
                                hintText: "Nhập tin nhắn...",
                                hintStyle:
                                    AppTextStyle.w400s15(ColorName.gray838),
                                contentPadding: const EdgeInsets.only(
                                  top: 15,
                                  left: 10,
                                  right: 10,
                                ),
                                border: inputBorder,
                                focusColor: ColorName.grayD2d,
                                focusedBorder: inputBorder,
                                enabledBorder: inputBorder,
                                errorBorder: inputBorder,
                              ),
                              keyboardType: TextInputType.multiline,
                            ),
                          ),
                          const SizedBox(width: 10),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: controller.onTapSent,
                            child: Assets.images.sendIcon.image(scale: 3),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool calculateTime(DateTime preTime, DateTime currentTime) {
  final minute = Jiffy(preTime).diff(currentTime, Units.MINUTE).abs();

  if (minute < 5) return true;
  return false;
}

String handleTime(DateTime dateTime) {
  final now = DateTime.now().day;
  final day = dateTime.day;
  if (now - day == 0) {
    return DateFormat('HH:mm').format(dateTime);
  }
  return DateFormat('HH:mm dd/MM/yyyy').format(dateTime);
}

void showBottomSheet(BuildContext context, ChatDetailController controller) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    context: context,
    builder: ((context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 6),
            Container(
              width: 32,
              height: 4,
              decoration: BoxDecoration(
                color: ColorName.grayC7c,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 10),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: controller.getPhoto,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.photo_camera,
                      color: ColorName.primaryColor,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Chụp ảnh',
                      style: AppTextStyle.w600s15(ColorName.black000),
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                height: 1,
                thickness: 1,
                color: ColorName.grayC7c,
              ),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: controller.getImageList,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.photo_album,
                      color: ColorName.primaryColor,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Chọn ảnh từ thư viện',
                      style: AppTextStyle.w600s15(ColorName.black000),
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                height: 1,
                thickness: 1,
                color: ColorName.grayC7c,
              ),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: controller.getVideo,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.video_collection,
                      color: ColorName.primaryColor,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Chọn video từ thư viện',
                      style: AppTextStyle.w600s15(ColorName.black000),
                    )
                  ],
                ),
              ),
            ),
          ],
        )),
  );
}
