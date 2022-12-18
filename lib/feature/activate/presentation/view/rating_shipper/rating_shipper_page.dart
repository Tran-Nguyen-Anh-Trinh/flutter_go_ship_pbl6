import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_app_bar.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/common.dart';
import 'package:flutter_go_ship_pbl6/feature/activate/presentation/controller/rating_shipper/rating_shipper_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/customer_info_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/order_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/shipper_model.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/extension/form_builder.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingShipperPage extends BaseWidget<RatingShipperController> {
  const RatingShipperPage({Key? key}) : super(key: key);

  @override
  Widget onBuild(BuildContext context) {
    return Obx(
      () {
        return GestureDetector(
          onTap: controller.hideKeyboard,
          child: Scaffold(
            appBar: BaseAppBar(
              title: Text(controller.rateInput.value.shipperView ? 'Đánh giá từ khách hàng' : 'Đánh giá tài xế'),
            ),
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                Positioned.fill(
                  child: Column(
                    children: [
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          const SizedBox(width: 25),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              height: 45,
                              width: 45,
                              imageUrl: controller.shipperInfo.value.avatarUrl ?? "",
                              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => Assets.images.profileIcon.image(width: 45),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.shipperInfo.value.name ?? 'Go Ship',
                                  style: AppTextStyle.w600s16(ColorName.black222),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  controller.shipperInfo.value.phoneNumber ?? '0384933379',
                                  style: AppTextStyle.w400s14(ColorName.black222),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 25),
                        ],
                      ),
                      const SizedBox(height: 25),
                      RatingBar.builder(
                        initialRating: controller.rate.value.toDouble(),
                        itemCount: 5,
                        minRating: 1,
                        ignoreGestures: controller.isViewOnly.value,
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
                        onRatingUpdate: (rating) {
                          controller.rate.value = rating.toInt();
                        },
                      ),
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CommonTextField(
                          isEnable: !controller.isViewOnly.value,
                          controller: controller.noteTextEditingController,
                          height: 208,
                          maxLines: 10,
                          type: FormFieldType.noteRate,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) {
                            controller.ratingShipper();
                          },
                        ),
                      ),
                      const Spacer(),
                      if (!controller.rateInput.value.shipperView)
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: controller.isViewOnly.value ? ColorName.grayBdb : ColorName.primaryColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                'Gửi đánh giá',
                                style: AppTextStyle.w600s16(ColorName.whiteFff),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (!controller.isViewOnly.value) {
                              controller.ratingShipper();
                            }
                          },
                        ),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
                if (controller.isLoading.value)
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
          ),
        );
      },
    );
  }
}

class RateInput {
  ShipperModel shipperModel;
  int orderID;
  bool shipperView;
  CustomerOrderModel? customerModel;
  RateInput(this.orderID, this.shipperModel, {this.shipperView = false, this.customerModel});
}
