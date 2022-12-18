import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/receive_order_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/repositoties/customer_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class RateOrderUsecase extends UseCaseIO<RateOrderRequest, void> {
  RateOrderUsecase(this._customerRepo);
  final CustomerRepo _customerRepo;

  @override
  Future<void> build(RateOrderRequest input) {
    return _customerRepo.rateOrder(input);
  }
}
