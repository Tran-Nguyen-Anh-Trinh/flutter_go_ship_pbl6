import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/receive_order_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/repositoties/customer_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class CustomerConfirmDonerOrderUsecase extends UseCaseIO<StatusOrderRequest, void> {
  CustomerConfirmDonerOrderUsecase(this._customerRepo);
  final CustomerRepo _customerRepo;

  @override
  Future<void> build(StatusOrderRequest input) {
    return _customerRepo.confirmOrder(input);
  }
}
