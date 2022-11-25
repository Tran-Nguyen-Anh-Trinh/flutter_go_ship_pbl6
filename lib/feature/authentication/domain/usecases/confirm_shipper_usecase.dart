import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/confirm_shipper_request.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/domain/repositoties/auth_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class ConfirmShipperUsecase extends UseCaseIO<ConfirmShipperRequest, void> {
  ConfirmShipperUsecase(this.authRepo);
  final AuthRepo authRepo;

  @override
  Future<void> build(ConfirmShipperRequest input) {
    return authRepo.confirmShipper(input);
  }
}
