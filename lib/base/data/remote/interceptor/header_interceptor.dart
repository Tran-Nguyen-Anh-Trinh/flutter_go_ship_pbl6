import 'package:dio/dio.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/account_model.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';

class HeaderInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Content-Type'] = 'application/json';

    AccountModel account = AppConfig.accountModel;
    if (account.accessToken != null) {
      options.headers["Authorization"] = "Bearer ${account.accessToken}";
    }

    handler.next(options);
  }
}
