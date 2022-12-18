import 'package:flutter_go_ship_pbl6/feature/home/data/models/rate_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/repositoties/customer_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class GetRateOrderUsecase extends UseCaseIO<int, RateModel> {
  GetRateOrderUsecase(this._customerRepo);
  final CustomerRepo _customerRepo;

  @override
  Future<RateModel> build(int input) {
    return _customerRepo.getRateOrderDetail(input);
  }
}
