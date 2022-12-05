import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/receive_order_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/repositoties/shipper_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class ReceiveOrderUsecase extends UseCaseIO<ReceiveOrderRequest, void> {
  ReceiveOrderUsecase(this._shipperRepo);
  final ShipperRepo _shipperRepo;

  @override
  Future<void> build(ReceiveOrderRequest input) {
    return _shipperRepo.receiveOrder(input);
  }
}
