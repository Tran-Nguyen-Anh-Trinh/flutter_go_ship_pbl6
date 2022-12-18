import 'package:flutter_go_ship_pbl6/feature/home/data/models/list_order_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/repositoties/customer_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class GetOrdersUsecase extends UseCaseIO<int, ListOrdersModel> {
  GetOrdersUsecase(this._customerRepo);
  final CustomerRepo _customerRepo;

  @override
  Future<ListOrdersModel> build(int input) {
    return _customerRepo.getOrders(input);
  }
}
