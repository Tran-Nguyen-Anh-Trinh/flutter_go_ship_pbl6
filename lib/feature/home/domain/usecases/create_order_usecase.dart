import 'package:flutter_go_ship_pbl6/feature/home/data/models/category_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/create_order_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/repositoties/customer_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class CreateOrderUsecase extends UseCaseIO<CreateOrderRequest, void> {
  CreateOrderUsecase(this._customerRepo);
  final CustomerRepo _customerRepo;

  @override
  Future<void> build(CreateOrderRequest input) {
    return _customerRepo.createOrder(input);
  }
}
