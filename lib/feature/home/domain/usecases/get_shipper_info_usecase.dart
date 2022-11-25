import 'package:flutter_go_ship_pbl6/feature/home/data/models/shipper_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/repositoties/shipper_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class GetShipperInfoUsecase extends UseCase<ShipperModel> {
  GetShipperInfoUsecase(this._shipperRepo);
  final ShipperRepo _shipperRepo;

  @override
  Future<ShipperModel> build() {
    return _shipperRepo.getShipperInfo();
  }
}
