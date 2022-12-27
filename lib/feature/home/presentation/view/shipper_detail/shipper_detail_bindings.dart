import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_shipper_rates_with_id_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_shipper_with_id_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/shipper_detail/shipper_detail_controller.dart';
import 'package:get/get.dart';

class ShipperDetailBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetShipperInfoWithIdUsecase(Get.find()));
    Get.lazyPut(() => GetShipperRatesWithIdUsecase(Get.find()));
    Get.put(ShipperDetailController(Get.find(), Get.find()));
  }
}
