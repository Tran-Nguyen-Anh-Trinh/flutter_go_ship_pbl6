import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/order_model.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'widget.g.dart';

@swidget
Widget orderActiveWidget({
  required OrderModel order,
  Function()? onPressed,
  bool topBorder = false,
}) {
  return CupertinoButton(
    padding: EdgeInsets.zero,
    onPressed: onPressed,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: const BoxDecoration(
        color: ColorName.whiteFff,
        border: Border(
          bottom: BorderSide(width: 0.2, color: ColorName.gray828),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              height: 75,
              width: 75,
              memCacheWidth: 85,
              memCacheHeight: 85,
              maxHeightDiskCache: 85,
              maxWidthDiskCache: 85,
              fit: BoxFit.cover,
              imageUrl: order.imgOrder ??
                  'https://firebasestorage.googleapis.com/v0/b/pbl6-goship.appspot.com/o/order_no_image.jpg?alt=media&token=41fedf4d-dd07-434c-9c3e-c610dc4d5f76',
              placeholder: (context, url) => const SizedBox(
                height: 40,
                width: 40,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Assets.images.orderNoImage.image(),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  order.description ?? "",
                  style: AppTextStyle.w500s15(ColorName.black000),
                ),
                const SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    color: ColorName.grayEce,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  child: Text(
                    order.customerNotes ?? "Không có lưu ý đến tài xế",
                    style: AppTextStyle.w500s12(ColorName.gray828),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "${double.parse(order.distance.toString()).toStringAsFixed(2)} km",
                      style: AppTextStyle.w700s14(ColorName.primaryColor),
                    ),
                    Text(
                      ' - ',
                      style: AppTextStyle.w700s14(ColorName.black000),
                    ),
                    Text(
                      order.cost.toString(),
                      style: AppTextStyle.w700s14(ColorName.green459),
                    ),
                    Text(
                      ' đ',
                      style: AppTextStyle.w600s12(ColorName.redEb5),
                    ),
                    const Spacer(),
                    Text(
                      "${order.createdAt!.hour}:${order.createdAt!.minute} ${order.createdAt!.day}-${order.createdAt!.month}-${order.createdAt!.year}",
                      style: AppTextStyle.w600s13(ColorName.black222),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

@swidget
Widget menuActive({
  required String title,
  required bool isActive,
  required Function() onPressed,
}) {
  return Container(
    height: 50,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    color: ColorName.whiteFff,
    child: CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Column(
        children: [
          const Spacer(),
          Center(
            child: Text(
              title,
              style: isActive ? AppTextStyle.w500s15(ColorName.primaryColor) : AppTextStyle.w500s15(ColorName.black222),
            ),
          ),
          const Spacer(),
          if (isActive)
            Container(
              height: 3,
              width: 25,
              decoration: BoxDecoration(
                color: ColorName.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
        ],
      ),
    ),
  );
}
