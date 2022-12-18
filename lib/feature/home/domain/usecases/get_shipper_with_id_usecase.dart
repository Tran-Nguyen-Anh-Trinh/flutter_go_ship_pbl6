import 'package:flutter_go_ship_pbl6/feature/home/data/models/shipper_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/repositoties/customer_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class GetShipperInfoWithIdUsecase extends UseCaseIO<int, ShipperModel> {
  GetShipperInfoWithIdUsecase(this._customerRepo);
  final CustomerRepo _customerRepo;

  @override
  Future<ShipperModel> build(int input) {
    return _customerRepo.getShipperInfoWithID(input);
  }
}
