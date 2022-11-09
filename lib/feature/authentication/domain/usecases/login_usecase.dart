import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/account_model.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/phone_password_request.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/domain/repositoties/auth_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class LoginUsecase extends UseCaseIO<PhonePasswordRequest, AccountModel> {
  LoginUsecase(this._authRepo);
  final AuthRepo _authRepo;

  @override
  Future<AccountModel> build(PhonePasswordRequest input) {
    return _authRepo.login(input);
  }
}
