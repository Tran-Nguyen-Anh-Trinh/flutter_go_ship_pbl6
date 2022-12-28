import 'package:flutter_go_ship_pbl6/feature/authentication/domain/repositoties/auth_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class CheckUserUsecase extends UseCaseIO<String, void> {
  CheckUserUsecase(this.authRepo);
  final AuthRepo authRepo;

  @override
  Future<void> build(String input) {
    return authRepo.checkUser(input);
  }
}
