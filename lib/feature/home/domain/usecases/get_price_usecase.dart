import 'package:flutter_go_ship_pbl6/feature/home/data/models/price_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/get_price_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/repositoties/customer_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class GetPriceUsecase extends UseCaseIO<GetPriceRequest, PriceModel> {
  GetPriceUsecase(this._customerRepo);
  final CustomerRepo _customerRepo;

  @override
  Future<PriceModel> build(GetPriceRequest input) {
    return _customerRepo.getPrice(input);
  }
}
