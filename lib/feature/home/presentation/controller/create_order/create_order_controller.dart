import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/account_model.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/token_request%20.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/domain/usecases/token_refresh_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/category_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/payment_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/price_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/shipper_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/create_order_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/get_price_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/create_order_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_all_category_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_all_payment_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_price_usecase.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/services/Firebase/cloud_storage.dart';
import 'package:flutter_go_ship_pbl6/utils/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateOrderController extends BaseController<String?> {
  CreateOrderController(
    this._categoryUsecase,
    this._getPaymentUsecase,
    this._refreshTokenUsecase,
    this._storageService,
    this._createOrderUsecase,
    this._cloudStorage,
    this._getPriceUsecase,
  );

  final GetCategoryUsecase _categoryUsecase;
  final GetPaymentUsecase _getPaymentUsecase;
  final StorageService _storageService;
  final RefreshTokenUsecase _refreshTokenUsecase;
  final CreateOrderUsecase _createOrderUsecase;
  final CloudStorage _cloudStorage;
  final GetPriceUsecase _getPriceUsecase;

  final _picker = ImagePicker();

  var startAddress = AddressModel().obs;
  var endAddress = AddressModel().obs;
  String? shipperID;

  RxList<CategoryModel> listCategory = RxList<CategoryModel>.empty();
  RxList<PaymentModel> listPayment = RxList<PaymentModel>.empty();

  ScrollController scrollController = ScrollController();

  var backgroundColor = ColorName.primaryColor.obs;

  var indexCategory = 0.obs;
  var indexPayment = 0.obs;

  final detailOrderTextEditingController = TextEditingController();
  final noteOrderTextEditingController = TextEditingController();

  var accessToken = AppConfig.accountInfo.accessToken;
  var loadState = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
    shipperID = input;
    scrollController.addListener(() {
      if (scrollController.position.pixels > 10) {
        backgroundColor.value = ColorName.backgroundColor;
      } else {
        backgroundColor.value = ColorName.primaryColor;
      }
    });
  }

  void loadData() async {
    if (AppConfig.listCategory.isNotEmpty && AppConfig.listPayment.isNotEmpty) {
      listPayment.value = AppConfig.listPayment;
      listCategory.value = AppConfig.listCategory;
      return;
    }
    AppConfig.accountInfo.accessToken = null;
    loadState.value = true;
    await _categoryUsecase.execute(
      observer: Observer(
        onSubscribe: () {},
        onSuccess: (categories) async {
          listCategory.value = categories;
          AppConfig.listCategory = categories;
          await _getPaymentUsecase.execute(
            observer: Observer(
              onSubscribe: () {},
              onSuccess: (payments) {
                listPayment.value = payments;
                AppConfig.listPayment = payments;
                AppConfig.accountInfo.accessToken = accessToken;
                loadState.value = false;
              },
              onError: (e) async {
                await showOkDialog(
                  message: "Hệ thống đang gặp một số trục trặc, quý khác vui lòng thử lại sau vài giây",
                  title: "Cảnh báo",
                );
                back();
                print(e);
              },
            ),
          );
        },
        onError: (e) async {
          await showOkDialog(
            message: "Hệ thống đang gặp một số trục trặc, quý khác vui lòng thử lại sau vài giây",
            title: "Cảnh báo",
          );
          back();
          print(e);
        },
      ),
    );
  }

  void chooseCategory(int index) {
    indexCategory.value = index;
    getPrice();
  }

  Rx<XFile> imageOrder = XFile('').obs;
  void pickImage(BuildContext context) async {
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
                onPressed: () async {
                  imageOrder.value = await _picker.pickImage(source: ImageSource.camera, imageQuality: 50) ?? XFile('');
                  back();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                  child: Text(
                    'Chụp ảnh',
                    style: AppTextStyle.w600s15(ColorName.black000),
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
                onPressed: () async {
                  imageOrder.value =
                      await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50) ?? XFile('');
                  back();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                  child: Text(
                    'Chọn ảnh từ thư viện',
                    style: AppTextStyle.w600s15(ColorName.black000),
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
            ],
          )),
    );
  }

  var distance = 0.0.obs;
  var price = PriceModel().obs;
  var createState = false.obs;
  var isShowPrice = false.obs;
  var isGetedPrice = false.obs;

  void getPrice() async {
    try {
      double lat1 = double.parse(startAddress.value.latitude ?? "0");
      double lon1 = double.parse(startAddress.value.longitude ?? "0");
      double lat2 = double.parse(endAddress.value.latitude ?? "0");
      double lon2 = double.parse(endAddress.value.longitude ?? "0");
      if (lat1 == 0 || lon1 == 0 || lat2 == 0 || lon2 == 0) {
        return;
      }
      distance.value = calculateDistance(lat1, lon1, lat2, lon2);
      if (distance < 0.5) {
        Get.closeAllSnackbars();
        Get.snackbar(
          "Chọn một vị trí khác để tạo đơn",
          "Không thể tạo đơn hàng với hai vị trí ở quá gần nhau!",
          titleText: Text(
            "Chọn một vị trí khác để tạo đơn",
            style: AppTextStyle.w600s15(ColorName.black000),
          ),
          messageText: Text(
            "Không thể tạo đơn hàng với hai vị trí ở quá gần nhau!",
            style: AppTextStyle.w400s12(ColorName.gray4f4),
          ),
          margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
          duration: const Duration(seconds: 4),
          backgroundColor: ColorName.whiteFaf,
          animationDuration: const Duration(milliseconds: 300),
          boxShadows: [
            BoxShadow(
              color: ColorName.black000.withOpacity(0.6),
              offset: const Offset(8, 8),
              blurRadius: 24,
            ),
          ],
        );
        scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        return;
      }
    } catch (e) {
      await showOkDialog(
        message: "Hệ thống đang gặp một số trục trặc, quý khác vui lòng thử lại sau vài giây!",
        title: "Cảnh báo",
      );
      back();
      return;
    }
    isShowPrice.value = true;
    isGetedPrice.value = false;
    _getPriceUsecase.execute(
      observer: Observer(
          onSubscribe: () {},
          onSuccess: (priceModel) {
            isGetedPrice.value = true;
            price.value = priceModel;
          },
          onError: (error) async {
            if (kDebugMode) {
              print(error);
            }
            await showOkDialog(
              message: "Hệ thống đang gặp một số trục trặc, quý khác vui lòng thử lại sau vài giây!",
              title: "Cảnh báo",
            );
            back();
            return;
          }),
      input: GetPriceRequest(
        distance.value,
        listCategory[indexCategory.value].isProtected ?? false ? 2 : 1,
      ),
    );
  }

  void createOrder() async {
    hideKeyboard();
    if (startAddress.value.addressNotes == null || endAddress.value.addressNotes == null) {
      Get.closeAllSnackbars();
      Get.snackbar(
        "Tạo mới đơn hàng thất bại",
        "Vui lòng chọn vị trí xuất phát và vị trí đến của đơn hàng!",
        titleText: Text(
          'Tạo mới đơn hàng thất bại',
          style: AppTextStyle.w600s15(ColorName.black000),
        ),
        messageText: Text(
          'Vui lòng chọn vị trí xuất phát và vị trí đến của đơn hàng!',
          style: AppTextStyle.w400s12(ColorName.gray4f4),
        ),
        margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
        duration: const Duration(seconds: 4),
        backgroundColor: ColorName.whiteFaf,
        animationDuration: const Duration(milliseconds: 300),
        boxShadows: [
          BoxShadow(
            color: ColorName.black000.withOpacity(0.6),
            offset: const Offset(8, 8),
            blurRadius: 24,
          ),
        ],
      );
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      return;
    }
    if (detailOrderTextEditingController.text.trim().isEmpty) {
      Get.closeAllSnackbars();
      Get.snackbar(
        "Tạo mới đơn hàng thất bại",
        "Vui lòng điền thông tin chi tiết đơn hàng!",
        titleText: Text(
          'Tạo mới đơn hàng thất bại',
          style: AppTextStyle.w600s15(ColorName.black000),
        ),
        messageText: Text(
          "Vui lòng điền thông tin chi tiết đơn hàng!",
          style: AppTextStyle.w400s12(ColorName.gray4f4),
        ),
        margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
        duration: const Duration(seconds: 4),
        backgroundColor: ColorName.whiteFaf,
        animationDuration: const Duration(milliseconds: 300),
        boxShadows: [
          BoxShadow(
            color: ColorName.black000.withOpacity(0.6),
            offset: const Offset(8, 8),
            blurRadius: 24,
          ),
        ],
      );
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      return;
    }
    if (distance < 0.5) {
      Get.snackbar(
        "Chọn một vị trí khác để tạo đơn",
        "Không thể tạo đơn hàng với hai vị trí ở quá gần nhau!",
        titleText: Text(
          "Chọn một vị trí khác để tạo đơn",
          style: AppTextStyle.w600s15(ColorName.black000),
        ),
        messageText: Text(
          "Không thể tạo đơn hàng với hai vị trí ở quá gần nhau!",
          style: AppTextStyle.w400s12(ColorName.gray4f4),
        ),
        margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
        duration: const Duration(seconds: 4),
        backgroundColor: ColorName.whiteFaf,
        animationDuration: const Duration(milliseconds: 300),
        boxShadows: [
          BoxShadow(
            color: ColorName.black000.withOpacity(0.6),
            offset: const Offset(8, 8),
            blurRadius: 24,
          ),
        ],
      );
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      return;
    }

    createState.value = true;
    String? url;
    if (imageOrder.value.path.isNotEmpty) {
      url = (await _cloudStorage.putAllxFile([imageOrder.value], folder: "Order")).first;
    }

    _createOrderUsecase.execute(
      observer: Observer(
        onSubscribe: () {},
        onSuccess: (_) async {
          Get.closeAllSnackbars();
          back();
          AudioPlayer player = AudioPlayer();
          String audioasset = "sound/notification.mp3";
          await player.play(AssetSource(audioasset), volume: 1);
          Get.snackbar(
            "Tạo mới đơn hàng thành công",
            "Vui lòng chờ trong giây lát tài xế sẽ liên hệ ngay cho bạn!",
            titleText: Text(
              "Tạo mới đơn hàng thành công",
              style: AppTextStyle.w600s15(ColorName.black000),
            ),
            messageText: Text(
              "Vui lòng chờ trong giây lát tài xế sẽ liên hệ ngay cho bạn!",
              style: AppTextStyle.w400s12(ColorName.gray4f4),
            ),
            margin: const EdgeInsets.symmetric(vertical: 90, horizontal: 25),
            duration: const Duration(seconds: 4),
            animationDuration: const Duration(milliseconds: 600),
            icon: Padding(
              padding: const EdgeInsets.all(8),
              child: Assets.images.logoIcon.image(width: 25),
            ),
            backgroundGradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.1, 0.9],
              colors: [ColorName.whiteFff, ColorName.primaryColor],
            ),
            backgroundColor: ColorName.whiteFff,
            overlayBlur: 0,
            barBlur: 1,
            boxShadows: [
              BoxShadow(
                color: ColorName.black000.withOpacity(0.6),
                offset: const Offset(8, 8),
                blurRadius: 24,
              ),
            ],
            snackStyle: SnackStyle.FLOATING,
            dismissDirection: DismissDirection.up,
          );
        },
        onError: (e) async {
          print(CreateOrderRequest(
            startAddress.value,
            endAddress.value,
            detailOrderTextEditingController.text.trim(),
            distance.value,
            noteOrderTextEditingController.text.trim().isNotEmpty ? noteOrderTextEditingController.text.trim() : null,
            url,
            listPayment[indexPayment.value].id,
            listCategory[indexCategory.value].id,
            shipper: shipperID,
          ).toJson());
          if (e is DioError) {
            if (kDebugMode) {
              print(e);
              print('===${e.response!.data["detail"].toString()}====');
            }
            if (e.response!.statusCode == 403) {
              var account = AppConfig.accountInfo;
              await _refreshTokenUsecase.execute(
                observer: Observer(
                  onSubscribe: () {},
                  onSuccess: (token) {
                    account.accessToken = token.access;
                    _storageService.setToken(account.toJson().toString());
                    AppConfig.accountInfo = account;
                    createOrder();
                  },
                  onError: (err) async {
                    if (kDebugMode) {
                      print('================${err}==================');
                    }
                    if (err is DioError) {
                      if (err.response!.statusCode == 401) {
                        await showOkDialog(
                          title: "Phiên đăng nhập của bạn đã hết hạng",
                          message: "Vui lòng thực hiện đăng nhập lại!",
                        );
                        _storageService.removeToken();
                        AppConfig.accountInfo = AccountModel();
                        N.toWelcomePage();
                        N.toLoginPage();
                      } else {
                        return;
                      }
                    }
                  },
                ),
                input: TokenRequest(account.refreshToken, account.accessToken),
              );
            } else {
              return;
            }
          }
        },
      ),
      input: CreateOrderRequest(
        startAddress.value,
        endAddress.value,
        detailOrderTextEditingController.text.trim(),
        distance.value,
        noteOrderTextEditingController.text.trim().isNotEmpty ? noteOrderTextEditingController.text.trim() : null,
        url,
        listPayment[indexPayment.value].id,
        listCategory[indexCategory.value].id,
        shipper: shipperID,
      ),
    );
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
