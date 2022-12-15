import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/receive_order_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/repositoties/shipper_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class DeliveryOrderUsecase extends UseCaseIO<StatusOrderRequest, void> {
  DeliveryOrderUsecase(this._shipperRepo);
  final ShipperRepo _shipperRepo;

  @override
  Future<void> build(StatusOrderRequest input) {
    return _shipperRepo.deliveryOrder(input);
  }
}
