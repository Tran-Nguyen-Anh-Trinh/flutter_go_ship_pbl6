import 'package:flutter/cupertino.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:get/get.dart';

part 'widget.g.dart';

@swidget
Widget trackingWidget({
  Function()? onClose,
  Function()? onTracking,
  Function()? onGoStartPoint,
  Function()? onGoEndPoint,
  Function()? onViewFull,
  Function()? onDelivery,
  String? km,
  String? time,
}) {
  var isTrackingModel = false.obs;
  var isViewFullModelModel = false.obs;
  return Obx(
    () => Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        color: ColorName.grayF8f,
      ),
      child: isTrackingModel.value
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 5,
                      width: 40,
                      decoration: BoxDecoration(
                        color: ColorName.gray838,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(width: 30),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                time ?? "12",
                                style: AppTextStyle.w600s25(ColorName.green459),
                              ),
                              Text(
                                " phút",
                                style: AppTextStyle.w500s20(ColorName.green459),
                              ),
                            ],
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${km ?? "5"} km",
                            style: AppTextStyle.w500s20(ColorName.gray838),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        isViewFullModelModel.value = !isViewFullModelModel.value;
                        if (isViewFullModelModel.value) {
                          onViewFull?.call();
                        } else {
                          onTracking?.call();
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: ColorName.whiteFff,
                          border: Border.all(width: 0.5, color: ColorName.black000),
                        ),
                        child: Center(
                          child: Assets.images.mapTrackingFullIcon.image(
                            width: 20,
                            height: 20,
                            color: ColorName.black000,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        isTrackingModel.value = false;
                        onViewFull?.call();
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorName.redFf3,
                        ),
                        child: Center(
                          child: Text(
                            'Thoát',
                            style: AppTextStyle.w500s13(ColorName.whiteFff),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(height: 25),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 5,
                      width: 40,
                      decoration: BoxDecoration(
                        color: ColorName.gray838,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(width: 25),
                    Text(
                      time ?? "12",
                      style: AppTextStyle.w600s20(ColorName.green459),
                    ),
                    Text(
                      " phút",
                      style: AppTextStyle.w500s15(ColorName.green459),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "(${km ?? "5"} km)",
                      style: AppTextStyle.w500s15(ColorName.gray838),
                    ),
                    const SizedBox(width: 25),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    'Tuyến đường tốt nhất hiện tại mà chúng tôi tìm được',
                    style: AppTextStyle.w500s15(ColorName.black333),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoButton(
                      onPressed: onDelivery,
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorName.whiteFff,
                            border: Border.all(
                              width: 1,
                              color: ColorName.primaryColor,
                              strokeAlign: StrokeAlign.inside,
                            )),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Assets.images.deliveryTrackingIcon.image(
                                width: 15,
                                height: 15,
                                color: ColorName.primaryColor,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Nhận hàng',
                                style: AppTextStyle.w500s13(ColorName.primaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () {
                        isTrackingModel.value = true;
                        onTracking?.call();
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorName.primaryColor,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Assets.images.startRouteIcon.image(
                                width: 15,
                                height: 15,
                                color: ColorName.whiteFff,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Bắt đầu',
                                style: AppTextStyle.w500s13(ColorName.whiteFff),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    CupertinoButton(
                      onPressed: onClose,
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorName.redFf3,
                        ),
                        child: Center(
                          child: Text(
                            'Thoát',
                            style: AppTextStyle.w500s13(ColorName.whiteFff),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: onViewFull,
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.5, color: ColorName.grayBdb),
                        top: BorderSide(width: 0.5, color: ColorName.grayBdb),
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 25),
                        Assets.images.mapsTrackingIcon.image(
                          width: 20,
                          height: 20,
                          color: ColorName.black000,
                        ),
                        const SizedBox(width: 25),
                        Expanded(
                          child: Text(
                            "Bản đồ",
                            style: AppTextStyle.w400s15(ColorName.black000),
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: onGoStartPoint,
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      children: [
                        const SizedBox(width: 25),
                        Assets.images.myLocationTrackingIcon.image(
                          width: 20,
                          height: 20,
                          color: ColorName.black000,
                        ),
                        const SizedBox(width: 25),
                        Expanded(
                          child: Text(
                            "Vị trí của bạn",
                            style: AppTextStyle.w400s15(ColorName.black000),
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: onGoEndPoint,
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.5, color: ColorName.grayBdb),
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 25),
                        Assets.images.endOrderMarker.image(
                          width: 20,
                          height: 20,
                          color: ColorName.black000,
                        ),
                        const SizedBox(width: 25),
                        Expanded(
                          child: Text(
                            "Vị trí đích đến",
                            style: AppTextStyle.w400s15(ColorName.black000),
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
    ),
  );
}
