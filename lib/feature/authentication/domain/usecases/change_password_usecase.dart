import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/change_password_request.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/domain/repositoties/auth_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class ChangePasswordUsecase extends UseCaseIO<ChangePasswordRequest, void> {
  ChangePasswordUsecase(this.authRepo);
  final AuthRepo authRepo;

  @override
  Future<void> build(ChangePasswordRequest input) {
    return authRepo.changePassword(input);
  }
}
