import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/account_model.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/change_password_request.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/confirm_shipper_request.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/phone_password_request.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/register_request%20.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/token_request%20.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/update_token_device_request.dart';

abstract class AuthRepo {
  Future<TokenRequest> refreshToken(TokenRequest request);
  Future<AccountModel> login(PhonePasswordRequest request);
  Future<AccountModel> register(RegisterRequest request);
  Future<void> confirmShipper(ConfirmShipperRequest request);
  Future<void> changePassword(ChangePasswordRequest request);
  Future<void> updateTokenDevice(UpdateTokenDeviceRequest request);
  Future<void> checkUser(String request);
}
