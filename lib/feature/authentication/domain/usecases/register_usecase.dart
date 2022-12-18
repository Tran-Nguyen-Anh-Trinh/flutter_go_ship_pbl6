import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/account_model.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/register_request%20.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/domain/repositoties/auth_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class RegisterUsecase extends UseCaseIO<RegisterRequest, AccountModel> {
  RegisterUsecase(this._authRepo);
  final AuthRepo _authRepo;

  @override
  Future<AccountModel> build(RegisterRequest input) {
    return _authRepo.register(input);
  }
}
