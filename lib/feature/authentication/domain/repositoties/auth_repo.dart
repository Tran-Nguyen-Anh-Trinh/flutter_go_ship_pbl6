import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/account_model.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/phone_password_request.dart';

import '../../data/models/list_user_model.dart';

abstract class AuthRepo {
   Future<AccountModel> login(PhonePasswordRequest request);
}