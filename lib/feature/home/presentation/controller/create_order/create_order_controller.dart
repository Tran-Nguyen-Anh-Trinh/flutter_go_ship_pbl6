import 'dart:math';

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
import 'package:flutter_go_ship_pbl6/feature/home/data/models/shipper_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/create_order_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/create_order_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_all_category_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_all_payment_usecase.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/services/Firebase/cloud_storage.dart';
import 'package:flutter_go_ship_pbl6/utils/services/storage_service.dart';
import 'package:image_picker/image_picker.dart';

class CreateOrderController extends BaseController {
  CreateOrderController(
    this._categoryUsecase,
    this._getPaymentUsecase,
    this._refreshTokenUsecase,
    this._storageService,
    this._createOrderUsecase,
    this._cloudStorage,
  );

  final GetCategoryUsecase _categoryUsecase;
  final GetPaymentUsecase _getPaymentUsecase;
  final StorageService _storageService;
  final RefreshTokenUsecase _refreshTokenUsecase;
  final CreateOrderUsecase _createOrderUsecase;
  final CloudStorage _cloudStorage;

  final _picker = ImagePicker();

  var startAddress = AddressModel().obs;
  var endAddress = AddressModel().obs;

  RxList<CategoryModel> listCategory = RxList<CategoryModel>.empty();
  RxList<PaymentModel> listPayment = RxList<PaymentModel>.empty();

  ScrollController scrollController = ScrollController();

  var backgroundColor = ColorName.primaryColor.obs;

  var indexCategory = 0;
  var indexPayment = 0;

  final detailOrderTextEditingController = TextEditingController();
  final noteOrderTextEditingController = TextEditingController();

  var accessToken = AppConfig.accountModel.accessToken;
  var loadState = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
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
    AppConfig.accountModel.accessToken = null;
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
                AppConfig.accountModel.accessToken = accessToken;
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
    indexCategory = index;
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

  var distance = 0.0;
  var createState = false.obs;

  void createOrder() async {
    if (startAddress.value.addressNotes == null || endAddress.value.addressNotes == null) {
      await showOkDialog(
        message: "Vui lòng chọn vị trí xuất phát và vị trí đến của đơn hàng!",
        title: "Tạo mới đơn hàng thất bại",
      );
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      return;
    }
    if (detailOrderTextEditingController.text.trim().isEmpty) {
      await showOkDialog(
        message: "Vui lòng điền thông tin chi tiết đơn hàng!",
        title: "Tạo mới đơn hàng thất bại",
      );
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      return;
    }
    try {
      double lat1 = double.parse(startAddress.value.latitude ?? "0");
      double lon1 = double.parse(startAddress.value.longitude ?? "0");
      double lat2 = double.parse(endAddress.value.latitude ?? "0");
      double lon2 = double.parse(endAddress.value.longitude ?? "0");
      distance = calculateDistance(lat1, lon1, lat2, lon2);
      if (distance < 0.5) {
        await showOkDialog(
          message: "Không thể tạo đơn hàng với hai vị trí ở quá gần nhau!",
          title: "Tạo mới đơn hàng thất bại",
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

    createState.value = true;
    String? url;
    if (imageOrder.value.path.isNotEmpty) {
      url = (await _cloudStorage.putAllxFile([imageOrder.value], folder: "Order")).first;
    }

    _createOrderUsecase.execute(
      observer: Observer(
        onSubscribe: () {},
        onSuccess: (_) async {
          await showOkDialog(
            message: "Vui lòng chờ trong giây lát shipper sẽ liên hệ ngay cho bạn!",
            title: "Tạo mới đơn hàng thành công",
          );
          back();
        },
        onError: (e) async {
          if (e is DioError) {
            if (kDebugMode) {
              print(e);
              print('===${e.response!.data["detail"].toString()}====');
            }
            if (e.response!.statusCode == 403) {
              var account = AppConfig.accountModel;
              await _refreshTokenUsecase.execute(
                observer: Observer(
                  onSubscribe: () {},
                  onSuccess: (token) {
                    account.accessToken = token.access;
                    _storageService.setToken(account.toJson().toString());
                    AppConfig.accountModel = account;
                    createOrder();
                  },
                  onError: (err) async {
                    print('================${err}==================');
                    if (err is DioError) {
                      if (err.response!.statusCode == 401) {
                        await showOkDialog(
                          title: "Phiên đăng nhập của bạn đã hết hạng",
                          message: "Vui lòng thực hiện đăng nhập lại!",
                        );
                        _storageService.removeToken();
                        AppConfig.accountModel = AccountModel();
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
        distance,
        noteOrderTextEditingController.text.trim().isNotEmpty ? noteOrderTextEditingController.text.trim() : null,
        url,
        listPayment[indexPayment].id,
        listCategory[indexCategory].id,
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