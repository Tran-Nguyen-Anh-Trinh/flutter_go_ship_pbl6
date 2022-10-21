import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../models/list_user_model.dart';

part 'user_api.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class UserAPI {
  factory UserAPI(Dio dioBuilder) = _UserAPI;

  @GET('/users')
  Future<ListUserModel> getUserData();
}
