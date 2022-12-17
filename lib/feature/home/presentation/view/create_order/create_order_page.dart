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
import 'package:flutter_dash/flutter_dash.dart';

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
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Positioned.fill(
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    bottomNavigationBar: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                        color: ColorName.whiteFff,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(-8, 0),
                            blurRadius: 24,
                            color: Color.fromARGB(255, 163, 163, 163),
                          ),
                          BoxShadow(
                            offset: Offset(8, 0),
                            blurRadius: 24,
                            color: Color.fromARGB(255, 163, 163, 163),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 6),
                          Container(
                            width: 35,
                            height: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                100,
                              ),
                              color: ColorName.grayC7c,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Tổng cộng:',
                                textAlign: TextAlign.center,
                                style: AppTextStyle.w600s15(ColorName.black000),
                              ),
                              const SizedBox(width: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    NumberFormat('#,##0')
                                        .format(
                                          controller.price.value.total ?? 0,
                                        )
                                        .replaceAll(',', '.'),
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.w600s20(
                                        ColorName.primaryColor),
                                  ),
                                  Text(
                                    ' đ',
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.w400s15(
                                        ColorName.green459),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            child: CommonButton(
                              height: 44,
                              onPressed: controller.createOrder,
                              fillColor:
                                  ColorName.primaryColor.withOpacity(0.9),
                              child: Text(
                                'Xác nhận',
                                style: AppTextStyle.w600s15(ColorName.whiteFff),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                    body: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
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
                                    color: ColorName.primaryColor,
                                    height: 150,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const SizedBox(width: 25),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              const SizedBox(height: 30),
                                              Text(
                                                "GoShip",
                                                style: AppTextStyle.w800s20(
                                                  ColorName.redFf0,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                "Giao nhận hàng mọi lúc, mọi nơi",
                                                style: AppTextStyle.w400s13(
                                                    ColorName.whiteFff),
                                                textAlign: TextAlign.left,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Assets.images.createOrderBannerIcon
                                                .image(width: 80),
                                            const SizedBox(height: 25),
                                          ],
                                        ),
                                        const SizedBox(width: 25),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 120,
                                      left: 40,
                                      right: 40,
                                    ),
                                    child: Container(
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: ColorName.black000
                                                .withOpacity(0.2),
                                            offset: const Offset(0, 8),
                                            blurRadius: 24,
                                          ),
                                        ],
                                        color: ColorName.whiteFff,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 3),
                                                  Expanded(
                                                    child: CupertinoButton(
                                                      padding: EdgeInsets.zero,
                                                      onPressed: () {
                                                        N.toOrderAddress(
                                                            isStartAddress:
                                                                true);
                                                      },
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.my_location,
                                                            color: Colors.red,
                                                          ),
                                                          const SizedBox(
                                                              width: 5),
                                                          Expanded(
                                                            child: Text(
                                                              controller
                                                                      .startAddress
                                                                      .value
                                                                      .addressNotes ??
                                                                  'Địa chỉ nhận hàng',
                                                              style:
                                                                  AppTextStyle
                                                                      .w400s12(
                                                                controller
                                                                            .startAddress
                                                                            .value
                                                                            .addressNotes !=
                                                                        null
                                                                    ? ColorName
                                                                        .primaryColor0b3
                                                                        .withOpacity(
                                                                            0.7)
                                                                    : ColorName
                                                                        .gray838,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 10,
                                                    ),
                                                    child: Dash(
                                                      direction: Axis.vertical,
                                                      length: 30,
                                                      dashLength: 8,
                                                      dashBorderRadius: 10,
                                                      dashThickness: 2,
                                                      dashColor: Color.fromARGB(
                                                          255, 182, 182, 182),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: CupertinoButton(
                                                      padding: EdgeInsets.zero,
                                                      onPressed: () {
                                                        N.toOrderAddress(
                                                            isStartAddress:
                                                                false);
                                                      },
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.location_city,
                                                            color: Colors.red,
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              controller
                                                                      .endAddress
                                                                      .value
                                                                      .addressNotes ??
                                                                  'Địa chỉ giao hàng',
                                                              style:
                                                                  AppTextStyle
                                                                      .w400s12(
                                                                controller
                                                                            .endAddress
                                                                            .value
                                                                            .addressNotes !=
                                                                        null
                                                                    ? ColorName
                                                                        .black000
                                                                    : ColorName
                                                                        .gray838,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
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
                                              if (!controller
                                                  .isGetedPrice.value)
                                                LoadingWidget(
                                                  color: ColorName
                                                      .primaryColor0b3
                                                      .withOpacity(0.7),
                                                )
                                              else
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            (controller.distance
                                                                    .value)
                                                                .toStringAsFixed(
                                                                    1),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: AppTextStyle
                                                                .w700s17(ColorName
                                                                    .black000),
                                                          ),
                                                          Text(
                                                            ' km',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: AppTextStyle
                                                                .w500s17(ColorName
                                                                    .gray4f4),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Text(
                                                        '.\n.\n.',
                                                        style: AppTextStyle
                                                            .w400s16(
                                                                ColorName
                                                                    .black000,
                                                                height: 0.4),
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow:
                                                            TextOverflow.clip,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            NumberFormat(
                                                                    '#,##0')
                                                                .format(
                                                                  controller
                                                                          .price
                                                                          .value
                                                                          .money ??
                                                                      0,
                                                                )
                                                                .replaceAll(
                                                                    ',', '.'),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: AppTextStyle
                                                                .w700s16(ColorName
                                                                    .green459),
                                                          ),
                                                          Text(
                                                            ' đ',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: AppTextStyle
                                                                .w600s10(
                                                                    ColorName
                                                                        .redFf0),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  const SizedBox(width: 5),
                                  Assets.images.detailOrder.image(width: 20),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Chi tiết đơn hàng*',
                                    style: AppTextStyle.w400s15(
                                        ColorName.black000),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorName.black000.withOpacity(0.2),
                                    offset: const Offset(0, 8),
                                    blurRadius: 24,
                                  ),
                                ],
                              ),
                              child: CommonTextField(
                                controller:
                                    controller.detailOrderTextEditingController,
                                height: 108,
                                maxLines: 10,
                                type: FormFieldType.detailOrder,
                                hasBorder: false,
                                textInputAction: TextInputAction.newline,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  const SizedBox(width: 5),
                                  Assets.images.orderNote.image(width: 20),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Lưu ý đến Shipper',
                                    style:
                                        AppTextStyle.w400s15(ColorName.redEb5),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorName.black000.withOpacity(0.2),
                                    offset: const Offset(0, 8),
                                    blurRadius: 24,
                                  ),
                                ],
                              ),
                              child: CommonTextField(
                                controller:
                                    controller.noteOrderTextEditingController,
                                height: 108,
                                maxLines: 10,
                                type: FormFieldType.noteOrder,
                                textInputAction: TextInputAction.done,
                                hasBorder: false,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  const SizedBox(width: 5),
                                  Assets.images.addImage.image(width: 20),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Hình ảnh mô tả',
                                    style: AppTextStyle.w400s15(
                                        ColorName.black000),
                                  ),
                                ],
                              ),
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              pressedOpacity: 0.7,
                              onPressed: () => controller.pickImage(context),
                              child: Container(
                                height: controller.imageOrder.value.path.isEmpty
                                    ? 200
                                    : null,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          ColorName.black000.withOpacity(0.2),
                                      offset: const Offset(0, 8),
                                      blurRadius: 24,
                                    ),
                                  ],
                                  color: ColorName.whiteFff,
                                ),
                                child: Center(
                                  child: controller
                                          .imageOrder.value.path.isEmpty
                                      ? const Icon(
                                          Icons.library_add,
                                          color: ColorName.primaryColor,
                                          size: 70,
                                        )
                                      : Image.file(
                                          File(
                                              controller.imageOrder.value.path),
                                          fit: BoxFit.fitWidth,
                                        ),
                                ),
                              ),
                            ),
                            if (controller.listCategory.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 16),
                                child: RadioButonGroup(
                                  controller.listCategory
                                      .map((element) => element.name ?? "")
                                      .toList(),
                                  icon: Assets.images.box.image(width: 20),
                                  title: "Loại hàng hóa",
                                  money: controller.price.value.extraPrice,
                                  isLoading: (!controller.isGetedPrice.value &&
                                      controller.isShowPrice.value),
                                  curentIndex: controller.indexCategory.value,
                                  callBack: (index) {
                                    controller.chooseCategory(index);
                                  },
                                ),
                              ),
                            if (controller.listPayment.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 16,
                                ),
                                child: RadioButonGroup(
                                  controller.listPayment
                                      .map((element) => element.type ?? "")
                                      .toList(),
                                  icon: Assets.images.paymentIcon
                                      .image(width: 20),
                                  title: "Phương thức thanh toán",
                                  curentIndex: controller.indexPayment.value,
                                  callBack: (index) {
                                    controller.chooseCategory(index);
                                  },
                                ),
                              ),
                            const SizedBox(height: 10),
                          ],
                        ),
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
