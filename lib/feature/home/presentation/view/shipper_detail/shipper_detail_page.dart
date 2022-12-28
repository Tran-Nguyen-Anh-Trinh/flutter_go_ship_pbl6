import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_app_bar.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/common.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/shipper_detail/shipper_detail_controller.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ShipperDetailPage extends BaseWidget<ShipperDetailController> {
  const ShipperDetailPage({Key? key}) : super(key: key);

  @override
  Widget onBuild(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    final kGradientBoxDecoration = BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.3, 0.9],
        colors: [ColorName.whiteFff, ColorName.primaryColor],
      ),
      borderRadius: BorderRadius.circular(82),
    );
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: BaseAppBar(
              title: Text(AppConfig.accountInfo.role == 1 ? 'Thông tin tài xế' : 'Đánh giá từ người dùng'),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: widthScreen * (196 / 375) + 75,
                    child: Stack(
                      children: [
                        Assets.images.profileBanner.image(width: widthScreen),
                        Positioned(
                          top: widthScreen * (196 / 375) - 80,
                          right: 25,
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: kGradientBoxDecoration,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CachedNetworkImage(
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                    imageUrl: controller.shipperInfo.value.avatarUrl ?? '',
                                    placeholder: (context, url) => const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Assets.images.profileIcon.image(height: 35, width: 35),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: widthScreen * (196 / 375) + 35,
                          right: 25,
                          child: Text(
                            controller.shipperInfo.value.name ?? 'Go Ship',
                            textAlign: TextAlign.right,
                            style: AppTextStyle.w700s22(ColorName.black000),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (AppConfig.accountInfo.role == 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: CommonButton(
                        onPressed: () {
                          controller.createOrder();
                        },
                        child: Text(
                          'Tạo đơn với tài xế này',
                          style: AppTextStyle.w500s15(ColorName.whiteFff),
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Assets.images.phoneIcon.image(width: 25, color: ColorName.primaryColor0b3),
                        const SizedBox(width: 10),
                        Text(
                          'Số điện thoại: ',
                          style: AppTextStyle.w400s17(ColorName.black000),
                        ),
                        Text(
                          controller.shipperInfo.value.phoneNumber ?? '0123456789',
                          style: AppTextStyle.w600s17(ColorName.black000),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        controller.shipperInfo.value.gender == 1
                            ? Assets.images.profileMaleIcon.image(width: 25)
                            : Assets.images.profileFemaleIcon.image(width: 25),
                        const SizedBox(width: 10),
                        Text(
                          'Giới tính: ',
                          style: AppTextStyle.w400s17(ColorName.black000),
                        ),
                        Text(
                          controller.shipperInfo.value.gender == 1 ? 'Nam' : 'Nữ',
                          style: AppTextStyle.w600s17(ColorName.black000),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.sentiment_very_satisfied,
                          color: Colors.green,
                          size: 25,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Tất cả đánh giá: ',
                          style: AppTextStyle.w400s17(ColorName.black000),
                        ),
                        Text(
                          '${controller.rateMean.value.toString()} ${controller.rateMean.value >= 4 ? '🤩' : controller.rateMean.value >= 3 ? '😍' : '😡'} ',
                          style: AppTextStyle.w600s17(ColorName.black222),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: RatingBar.builder(
                      initialRating: controller.rateMean.value.floorToDouble(),
                      itemCount: 5,
                      minRating: 1,
                      ignoreGestures: true,
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return const Icon(
                              Icons.sentiment_very_dissatisfied,
                              color: Colors.red,
                            );
                          case 1:
                            return const Icon(
                              Icons.sentiment_dissatisfied,
                              color: Colors.redAccent,
                            );
                          case 2:
                            return const Icon(
                              Icons.sentiment_neutral,
                              color: Colors.amber,
                            );
                          case 3:
                            return const Icon(
                              Icons.sentiment_satisfied,
                              color: Colors.lightGreen,
                            );
                          case 4:
                            return const Icon(
                              Icons.sentiment_very_satisfied,
                              color: Colors.green,
                            );
                          default:
                            return const Icon(
                              Icons.sentiment_very_satisfied,
                              color: Colors.green,
                            );
                        }
                      },
                      onRatingUpdate: (rating) {},
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.rates.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        constraints: const BoxConstraints(maxHeight: 50),
                        decoration: const BoxDecoration(
                          color: ColorName.whiteFff,
                          border: Border(
                            bottom: BorderSide(width: 1, color: ColorName.grayBdb),
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 20),
                            Assets.images.profileIcon.image(width: 30),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                controller.rates[index].feedback ?? '',
                                style: AppTextStyle.w400s15(ColorName.black000),
                              ),
                            ),
                            const SizedBox(width: 12),
                            RatingBar.builder(
                              initialRating: (controller.rates[index].rate ?? 1).toDouble(),
                              itemCount: 5,
                              minRating: 1,
                              ignoreGestures: true,
                              itemSize: 25,
                              itemBuilder: (context, index) {
                                switch (index) {
                                  case 0:
                                    return const Icon(
                                      Icons.sentiment_very_dissatisfied,
                                      color: Colors.red,
                                    );
                                  case 1:
                                    return const Icon(
                                      Icons.sentiment_dissatisfied,
                                      color: Colors.redAccent,
                                    );
                                  case 2:
                                    return const Icon(
                                      Icons.sentiment_neutral,
                                      color: Colors.amber,
                                    );
                                  case 3:
                                    return const Icon(
                                      Icons.sentiment_satisfied,
                                      color: Colors.lightGreen,
                                    );
                                  case 4:
                                    return const Icon(
                                      Icons.sentiment_very_satisfied,
                                      color: Colors.green,
                                    );
                                  default:
                                    return const Icon(
                                      Icons.sentiment_very_satisfied,
                                      color: Colors.green,
                                    );
                                }
                              },
                              onRatingUpdate: (rating) {},
                            ),
                            const SizedBox(width: 16),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          if (controller.loadingState.value)
            Positioned.fill(
              child: Container(
                color: ColorName.black000.withOpacity(0.6),
                child: const LoadingWidget(
                  color: ColorName.whiteFff,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
