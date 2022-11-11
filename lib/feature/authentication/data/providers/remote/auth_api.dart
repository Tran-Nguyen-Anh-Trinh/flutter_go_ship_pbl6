import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/account_model.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/phone_password_request.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/register_request%20.dart';
import 'package:retrofit/http.dart';

part 'auth_api.g.dart';

@RestApi(parser: Parser.DartJsonMapper)
abstract class AuthAPI {
  factory AuthAPI(Dio dioBuilder) = _AuthAPI;

  @POST('/login/')
  Future<AccountModel> login(@Body() PhonePasswordRequest request);

  @POST('/register/')
  Future<AccountModel> register(@Body() RegisterRequest request);
}
