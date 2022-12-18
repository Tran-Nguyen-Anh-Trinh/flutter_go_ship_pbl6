import 'package:flutter_go_ship_pbl6/feature/home/data/models/order_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/repositoties/shipper_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class GetOrderDetailUsecase extends UseCaseIO<int, OrderModel> {
  GetOrderDetailUsecase(this._shipperRepo);
  final ShipperRepo _shipperRepo;

  @override
  Future<OrderModel> build(int input) {
    return _shipperRepo.getOrderById(input);
  }
}
