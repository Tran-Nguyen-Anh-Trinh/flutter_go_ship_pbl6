import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/account_model.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/auth_api.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/change_password_request.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/confirm_shipper_request.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/phone_password_request.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/register_request%20.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/token_request%20.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/domain/repositoties/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final _authAPI = Get.find<AuthAPI>();

  @override
  Future<AccountModel> login(PhonePasswordRequest request) {
    return _authAPI.login(request);
  }

  @override
  Future<AccountModel> register(RegisterRequest request) {
    return _authAPI.register(request);
  }

  @override
  Future<TokenRequest> refreshToken(TokenRequest request) {
    return _authAPI.refreshToken(request);
  }

  @override
  Future<void> confirmShipper(ConfirmShipperRequest request) {
    return _authAPI.confirmShipper(request);
  }

  @override
  Future<void> changePassword(ChangePasswordRequest request) {
    return _authAPI.changePassword(request);
  }
}
