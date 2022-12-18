import 'package:flutter_go_ship_pbl6/feature/authentication/domain/usecases/token_refresh_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/create_order_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_all_category_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_all_payment_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_price_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/create_order/create_order_controller.dart';
import 'package:get/get.dart';

class CreateOrderBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetCategoryUsecase(Get.find()));
    Get.lazyPut(() => GetPaymentUsecase(Get.find()));
    Get.lazyPut(() => RefreshTokenUsecase(Get.find()));
    Get.lazyPut(() => CreateOrderUsecase(Get.find()));
    Get.lazyPut(() => GetPriceUsecase(Get.find()));
    Get.put(CreateOrderController(
      Get.find(),
      Get.find(),
      Get.find(),
      Get.find(),
      Get.find(),
      Get.find(),
      Get.find(),
    ));
  }
}
