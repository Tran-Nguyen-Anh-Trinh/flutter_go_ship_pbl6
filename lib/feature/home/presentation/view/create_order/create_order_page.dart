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

class CreateOrderPage extends BaseWidget<CreateOrderController> {
  const CreateOrderPage({Key? key}) : super(key: key);

  @override
  Widget onBuild(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: controller.hideKeyboard,
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
                          height: 220,
                          child: Stack(
                            children: [
                              Container(
                                color: ColorName.primaryColor,
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
                                        Assets.images.box.image(width: 70),
                                        const SizedBox(height: 65),
                                      ],
                                    ),
                                    const SizedBox(width: 25),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 90, left: 25, right: 25),
                                child: Container(
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorName.black000.withOpacity(0.3),
                                        offset: const Offset(8, 8),
                                        blurRadius: 10,
                                      ),
                                    ],
                                    color: ColorName.whiteFff,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 25),
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
                                                          ? ColorName.primaryColor
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
                                                Assets.images.endOrderMarker.image(width: 25),
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
                                  offset: const Offset(8, 8),
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
                              callBack: (index) {
                                controller.chooseCategory(index);
                              },
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                          child: CommonButton(
                            height: 44,
                            onPressed: controller.createOrder,
                            fillColor: ColorName.primaryColor,
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
    );
  }
}
