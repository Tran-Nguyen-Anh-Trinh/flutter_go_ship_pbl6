import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/token_request%20.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/domain/repositoties/auth_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class RefreshTokenUsecase extends UseCaseIO<TokenRequest, TokenRequest> {
  RefreshTokenUsecase(this.authRepo);
  final AuthRepo authRepo;

  @override
  Future<TokenRequest> build(TokenRequest input) {
    return authRepo.refreshToken(input);
  }
}
