import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_app_bar.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/common.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/create_order/create_order_controller.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/extension/form_builder.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:intl/intl.dart';

class CreateOrderPage extends BaseWidget<CreateOrderController> {
  const CreateOrderPage({Key? key}) : super(key: key);

  @override
  Widget onBuild(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: controller.hideKeyboard,
        child: Container(
          color: ColorName.backgroundColor,
          child: Scaffold(
            appBar: BaseAppBar(
              title: const Text('Tạo mới đơn hàng'),
            ),
            backgroundColor: controller.backgroundColor.value,
            body: Stack(
              children: [
                Positioned.fill(
                  child: SingleChildScrollView(
                    controller: controller.scrollController,
                    child: Container(
                      color: ColorName.backgroundColor,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 250,
                            child: Stack(
                              children: [
                                Container(
                                  color: ColorName.primaryColor0b3.withOpacity(0.7),
                                  height: 150,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const SizedBox(width: 25),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            const SizedBox(height: 25),
                                            Text(
                                              "GoShip",
                                              style: AppTextStyle.w600s20(ColorName.whiteFff),
                                              textAlign: TextAlign.left,
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "Giao nhận hàng mọi lúc, mọi nơi",
                                              style: AppTextStyle.w500s15(ColorName.whiteFff),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Assets.images.createOrderBannerIcon.image(width: 80),
                                          const SizedBox(height: 25),
                                        ],
                                      ),
                                      const SizedBox(width: 5),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 120, left: 25, right: 25),
                                  child: Container(
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorName.black000.withOpacity(0.3),
                                          offset: const Offset(5, 5),
                                          blurRadius: 10,
                                        ),
                                      ],
                                      color: ColorName.whiteFff,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 25),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 3),
                                                Expanded(
                                                  child: CupertinoButton(
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {
                                                      N.toOrderAddress(isStartAddress: true);
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Assets.images.startOrderMarker.image(width: 25),
                                                        const SizedBox(width: 5),
                                                        Expanded(
                                                          child: Text(
                                                            controller.startAddress.value.addressNotes ?? 'Giao ở đâu?',
                                                            style: AppTextStyle.w400s13(
                                                              controller.startAddress.value.addressNotes != null
                                                                  ? ColorName.primaryColor0b3.withOpacity(0.7)
                                                                  : ColorName.grayBdb,
                                                            ),
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10),
                                                  child: Text(
                                                    '.\n.\n.',
                                                    style: AppTextStyle.w400s16(ColorName.black000, height: 0.4),
                                                    textAlign: TextAlign.start,
                                                    overflow: TextOverflow.clip,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CupertinoButton(
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {
                                                      N.toOrderAddress(isStartAddress: false);
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Assets.images.endOrderMarker.image(width: 25, height: 20),
                                                        const SizedBox(width: 5),
                                                        Expanded(
                                                          child: Text(
                                                            controller.endAddress.value.addressNotes ?? 'Giao đến đâu?',
                                                            style: AppTextStyle.w400s13(
                                                              controller.endAddress.value.addressNotes != null
                                                                  ? ColorName.black000
                                                                  : ColorName.grayBdb,
                                                            ),
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 3),
                                              ],
                                            ),
                                          ),
                                          if (controller.isShowPrice.value)
                                            if (!controller.isGetedPrice.value)
                                              LoadingWidget(
                                                color: ColorName.primaryColor0b3.withOpacity(0.7),
                                              )
                                            else
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          (controller.distance.value).toStringAsFixed(1),
                                                          textAlign: TextAlign.center,
                                                          style: AppTextStyle.w700s17(ColorName.black000),
                                                        ),
                                                        Text(
                                                          ' km',
                                                          textAlign: TextAlign.center,
                                                          style: AppTextStyle.w500s17(ColorName.gray4f4),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 10),
                                                    child: Text(
                                                      '.\n.\n.',
                                                      style: AppTextStyle.w400s16(ColorName.black000, height: 0.4),
                                                      textAlign: TextAlign.start,
                                                      overflow: TextOverflow.clip,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          NumberFormat('#,##0')
                                                              .format(
                                                                controller.price.value.money ?? 0,
                                                              )
                                                              .replaceAll(',', '.'),
                                                          textAlign: TextAlign.center,
                                                          style: AppTextStyle.w700s16(ColorName.green459),
                                                        ),
                                                        Text(
                                                          ' đ',
                                                          textAlign: TextAlign.center,
                                                          style: AppTextStyle.w600s10(ColorName.redFf0),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                const SizedBox(width: 5),
                                Assets.images.detailOrder.image(width: 20),
                                const SizedBox(width: 5),
                                Text(
                                  'Chi tiết đơn hàng*',
                                  style: AppTextStyle.w500s17(ColorName.black000),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            child: CommonTextField(
                              controller: controller.detailOrderTextEditingController,
                              height: 108,
                              maxLines: 10,
                              type: FormFieldType.detailOrder,
                              textInputAction: TextInputAction.newline,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                const SizedBox(width: 5),
                                Assets.images.orderNote.image(width: 20),
                                const SizedBox(width: 5),
                                Text(
                                  'Lưu ý đến Shipper',
                                  style: AppTextStyle.w500s17(ColorName.redEb5),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            child: CommonTextField(
                              controller: controller.noteOrderTextEditingController,
                              height: 108,
                              maxLines: 10,
                              type: FormFieldType.noteOrder,
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                const SizedBox(width: 5),
                                Assets.images.addImage.image(width: 20),
                                const SizedBox(width: 5),
                                Text(
                                  'Hình ảnh mô tả',
                                  style: AppTextStyle.w500s17(ColorName.black000),
                                ),
                              ],
                            ),
                          ),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () => controller.pickImage(context),
                            child: Container(
                              height: controller.imageOrder.value.path.isEmpty ? 200 : null,
                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorName.black000.withOpacity(0.3),
                                    offset: const Offset(5, 5),
                                    blurRadius: 10,
                                  ),
                                ],
                                color: ColorName.whiteFff,
                              ),
                              child: Center(
                                child: controller.imageOrder.value.path.isEmpty
                                    ? Assets.images.orderImageIcon.image(width: 50)
                                    : Image.file(
                                        File(controller.imageOrder.value.path),
                                        fit: BoxFit.fitWidth,
                                      ),
                              ),
                            ),
                          ),
                          if (controller.listCategory.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                              child: RadioButonGroup(
                                controller.listCategory.map((element) => element.name ?? "").toList(),
                                icon: Assets.images.box.image(width: 20),
                                title: "Loại hàng hóa",
                                money: controller.price.value.extraPrice,
                                isLoading: (!controller.isGetedPrice.value && controller.isShowPrice.value),
                                curentIndex: controller.indexCategory.value,
                                callBack: (index) {
                                  controller.chooseCategory(index);
                                },
                              ),
                            ),
                          if (controller.listPayment.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                              child: RadioButonGroup(
                                controller.listPayment.map((element) => element.type ?? "").toList(),
                                icon: Assets.images.paymentIcon.image(width: 20),
                                title: "Phương thức thanh toán",
                                curentIndex: controller.indexPayment.value,
                                callBack: (index) {
                                  controller.chooseCategory(index);
                                },
                              ),
                            ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tổng cộng:',
                                textAlign: TextAlign.center,
                                style: AppTextStyle.w700s17(ColorName.black000),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                NumberFormat('#,##0')
                                    .format(
                                      controller.price.value.total ?? 0,
                                    )
                                    .replaceAll(',', '.'),
                                textAlign: TextAlign.center,
                                style: AppTextStyle.w700s16(ColorName.green459),
                              ),
                              Text(
                                ' đ',
                                textAlign: TextAlign.center,
                                style: AppTextStyle.w600s10(ColorName.redFf0),
                              ),
                              const SizedBox(width: 16),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                            child: CommonButton(
                              height: 44,
                              onPressed: controller.createOrder,
                              fillColor: ColorName.primaryColor0b3.withOpacity(0.7),
                              child: Text(
                                'Tạo mới đơn hàng',
                                style: AppTextStyle.w600s16(ColorName.whiteFff),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
                if (controller.createState.value)
                  Positioned.fill(
                    child: Container(
                      color: ColorName.black000.withOpacity(0.6),
                      child: const LoadingWidget(
                        color: ColorName.whiteFff,
                      ),
                    ),
                  ),
                if (controller.loadState.value)
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
        ),
      ),
    );
  }
}
