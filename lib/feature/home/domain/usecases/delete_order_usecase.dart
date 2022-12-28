import 'package:flutter_go_ship_pbl6/feature/home/domain/repositoties/shipper_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class DeleteOrderUsecase extends UseCaseIO<int, void> {
  DeleteOrderUsecase(this._shipperRepo);
  final ShipperRepo _shipperRepo;

  @override
  Future<void> build(int input) {
    return _shipperRepo.deleteOrder(input);
  }
}
