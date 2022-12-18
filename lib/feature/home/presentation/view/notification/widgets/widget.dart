import 'package:flutter/cupertino.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/notification_model.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:intl/intl.dart';

part 'widget.g.dart';

@swidget
Widget notificationWidget({
  required NotificationModel notification,
  Function()? onPressed,
  bool topBorder = false,
}) {
  return CupertinoButton(
    padding: EdgeInsets.zero,
    onPressed: onPressed,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: notification.isSeen ?? false
            ? ColorName.whiteFff
            : ColorName.grayC7c.withOpacity(0.8),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Text(
                            'Đơn hàng',
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Text(
                            'Nhận đơn',
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Text(
                            'Vận chuyển',
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Text(
                            'Xác nhận đơn hàng',
                            style: AppTextStyle.w400s10(ColorName.whiteFff),
                            overflow: TextOverflow.ellipsis,
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
          SizedBox(
            width: 100,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 45,
                  width: 1,
                  color: ColorName.gray828,
                ),
                timeNotification(time: notification.data?.time ?? "0"),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget timeNotification({required String time}) {
  var currentTime = DateTime.now().millisecondsSinceEpoch;
  var timeNotification = int.parse(time) - 3 * 60 * 60 * 1000 - 45 * 60 * 1000;
  var timeDifference = currentTime - timeNotification;
  timeDifference ~/= 1000;
  timeDifference ~/= 60;
  int minutes = timeDifference % 60;
  timeDifference ~/= 60;
  int hours = timeDifference;
  timeDifference = timeDifference ~/ 24;
  int days = timeDifference;
  timeDifference = timeDifference ~/ 30;

  var textTime = "19:00";
  var textDay = "Hôm nay";
  var dateTime = DateTime.fromMillisecondsSinceEpoch(
    timeNotification,
    isUtc: true,
  );
  if (minutes == 0) {
    textTime = "Vừa xong";
    textDay = "Hôm nay";
  } else if (minutes < 60) {
    textTime = DateFormat('HH:mm').format(dateTime);
    textDay = "Hôm nay";
  } else if (hours < 24) {
    textTime = DateFormat('HH:mm').format(dateTime);
    textDay = "Hôm nay";
  } else if (days < 5) {
    textTime = DateFormat('HH:mm').format(dateTime);
    textDay = "$days ngày trước";
  } else {
    textDay = DateFormat('dd-MM-yyyy').format(dateTime);
    textTime = DateFormat('HH:mm').format(dateTime);
  }

  return Row(
    children: [
      Text(
        textTime,
        style: AppTextStyle.w400s10(ColorName.black222),
      ),
      const SizedBox(width: 3),
      Text(
        "-",
        style: AppTextStyle.w400s10(ColorName.black222),
      ),
      const SizedBox(width: 3),
      Text(
        textDay,
        style: AppTextStyle.w400s10(ColorName.black222),
      ),
    ],
  );
}
