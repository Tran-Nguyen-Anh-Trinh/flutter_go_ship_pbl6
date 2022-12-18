import 'package:flutter_go_ship_pbl6/feature/home/data/models/list_order_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/repositoties/customer_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class GetOrderWithStatusUsecase extends UseCaseIO<GetOrderWithStatusRequest, ListOrdersModel> {
  GetOrderWithStatusUsecase(this._customerRepo);
  final CustomerRepo _customerRepo;

  @override
  Future<ListOrdersModel> build(GetOrderWithStatusRequest input) {
    return _customerRepo.getOrdersWithStatus(input.page, input.statusId);
  }
}

class GetOrderWithStatusRequest {
  int page;
  int statusId;
  GetOrderWithStatusRequest({required this.page, required this.statusId});
}
