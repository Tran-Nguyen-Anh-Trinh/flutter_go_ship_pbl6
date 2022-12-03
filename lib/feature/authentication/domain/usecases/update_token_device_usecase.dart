import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/update_token_device_request.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/domain/repositoties/auth_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class UpdateTokenDeviceUsecase extends UseCaseIO<UpdateTokenDeviceRequest, void> {
  UpdateTokenDeviceUsecase(this.authRepo);
  final AuthRepo authRepo;

  @override
  Future<void> build(UpdateTokenDeviceRequest input) {
    return authRepo.updateTokenDevice(input);
  }
}
