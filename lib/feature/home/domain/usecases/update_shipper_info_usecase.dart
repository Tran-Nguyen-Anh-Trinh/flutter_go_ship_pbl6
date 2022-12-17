import 'package:flutter_go_ship_pbl6/base/domain/base_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/repositoties/customer_repo.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/repositoties/shipper_repo.dart';

import '../../data/models/customer_info_model.dart';
import '../../data/models/shipper_model.dart';
import '../../data/providers/remote/request/customer_request.dart';
import '../../data/providers/remote/request/shipper_request.dart';

class UpdateShipperInfoUsecase extends UseCaseIO<ShipperRequest, ShipperModel?> {
  UpdateShipperInfoUsecase(this._shipperRepo);
  ShipperRepo _shipperRepo;

  @override
  Future<ShipperModel?> build(ShipperRequest input) {
    return _shipperRepo.updateShipperInfo(input);
  }
}
