import 'package:flutter/cupertino.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/notification_model.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

part 'widget.g.dart';

@swidget
Widget notificationWidget({
  required NotificationModel notification,
  Function()? onPressed,
  bool topBorder = false,
}) {
  var isShowFull = false.obs;
  return GestureDetector(
    onLongPress: () {
      isShowFull.value = !isShowFull.value;
    },
    child: CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.only(left: 10, top: 15, bottom: 15),
        decoration: BoxDecoration(
          color: notification.isSeen ?? false ? ColorName.whiteFff : ColorName.grayC7c.withOpacity(0.8),
          border: const Border(
            bottom: BorderSide(width: 0.5, color: ColorName.gray828),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (notification.data?.type == 1)
                        Container(
                          decoration: BoxDecoration(
                            color: ColorName.primaryColor,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Text(
                              '????n h??ng',
                              style: AppTextStyle.w400s10(ColorName.whiteFff),
                            ),
                          ),
                        ),
                      if (notification.data?.type == 2)
                        Container(
                          decoration: BoxDecoration(
                            color: ColorName.green459,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Text(
                              'Nh???n ????n',
                              style: AppTextStyle.w400s10(ColorName.whiteFff),
                            ),
                          ),
                        ),
                      if (notification.data?.type == 3)
                        Container(
                          decoration: BoxDecoration(
                            color: ColorName.primaryColor0b3,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Text(
                              'Giao h??ng',
                              style: AppTextStyle.w400s10(ColorName.whiteFff),
                            ),
                          ),
                        ),
                      if (notification.data?.type == 4)
                        Container(
                          decoration: BoxDecoration(
                            color: ColorName.redEb5,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Text(
                              'Hu??? ????n',
                              style: AppTextStyle.w400s10(ColorName.whiteFff),
                            ),
                          ),
                        ),
                      if (notification.data?.type == 5)
                        Container(
                          decoration: BoxDecoration(
                            color: ColorName.orangeFa9,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Text(
                              'Y??u c???u x??c nh???n',
                              style: AppTextStyle.w400s10(ColorName.whiteFff),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      if (notification.data?.type == 6)
                        Container(
                          decoration: BoxDecoration(
                            color: ColorName.green459,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Text(
                              'X??c nh???n ????n h??ng',
                              style: AppTextStyle.w500s12(ColorName.whiteFff),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      if (notification.data?.type == 7)
                        Container(
                          decoration: BoxDecoration(
                            color: ColorName.successColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Text(
                              '????nh gi??',
                              style: AppTextStyle.w500s12(ColorName.whiteFff),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      if (notification.data?.type == 8)
                        Container(
                          decoration: BoxDecoration(
                            color: ColorName.redEb5,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Text(
                              'Hu??? ????n',
                              style: AppTextStyle.w400s10(ColorName.whiteFff),
                            ),
                          ),
                        ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          notification.title ?? "",
                          style: AppTextStyle.w600s13(ColorName.black000),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    notification.body ?? "",
                    style: AppTextStyle.w400s13(ColorName.gray828),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Obx(() {
              return isShowFull.value
                  ? const SizedBox.shrink()
                  : SizedBox(
                      width: 120,
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            height: 45,
                            width: 1,
                            color: ColorName.gray828,
                          ),
                          Expanded(
                            child: Center(
                              child: timeNotification(time: notification.data?.time ?? "0"),
                            ),
                          ),
                        ],
                      ),
                    );
            })
          ],
        ),
      ),
    ),
  );
}

Widget timeNotification({required String time}) {
  var currentTime = DateTime.now().toUtc().millisecondsSinceEpoch;
  var timeNotification = int.parse(time) + (7 * 1000 * 60 * 60);
  var timeDifference = currentTime - timeNotification;

  timeDifference ~/= 1000;
  timeDifference ~/= 60;
  int minutes = timeDifference;
  timeDifference ~/= 60;
  int hours = timeDifference;
  timeDifference = timeDifference;
  timeDifference ~/= 24;
  int days = timeDifference;

  var textTime = "19:00";
  var textDay = "H??m nay";
  var dateTime = DateTime.fromMillisecondsSinceEpoch(
    timeNotification,
    isUtc: true,
  );
  if (minutes == 0) {
    textTime = "V???a xong";
    textDay = "H??m nay";
  } else if (minutes < 60) {
    textTime = DateFormat('HH:mm').format(dateTime);
    textDay = "H??m nay";
  } else if (hours < 24) {
    textTime = DateFormat('HH:mm').format(dateTime);
    textDay = "H??m nay";
  } else if (days < 10) {
    textTime = DateFormat('HH:mm').format(dateTime);
    textDay = "$days ng??y tr?????c";
  } else {
    textDay = DateFormat('dd-MM-yyyy').format(dateTime);
    textTime = DateFormat('HH:mm').format(dateTime);
  }

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        textTime,
        style: AppTextStyle.w500s10(ColorName.black222),
      ),
      const SizedBox(width: 3),
      Text(
        "--",
        style: AppTextStyle.w400s10(ColorName.black222),
      ),
      const SizedBox(width: 3),
      Text(
        textDay,
        style: AppTextStyle.w500s10(ColorName.black222),
      ),
    ],
  );
}
