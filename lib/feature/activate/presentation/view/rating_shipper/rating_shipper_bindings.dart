import 'package:flutter_go_ship_pbl6/feature/activate/presentation/controller/rating_shipper/rating_shipper_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_rate_order_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/rate_order_usecase.dart';
import 'package:get/get.dart';

class RatingShipperBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RateOrderUsecase(Get.find()));
    Get.lazyPut(() => GetRateOrderUsecase(Get.find()));
    Get.put(RatingShipperController(Get.find(), Get.find()));
  }
}
