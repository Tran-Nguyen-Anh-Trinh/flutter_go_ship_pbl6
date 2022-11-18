import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/account_model.dart';
import 'package:flutter_go_ship_pbl6/utils/services/storage_service_impl.dart';

class HeaderInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Content-Type'] = 'application/json';

    StorageServiceImpl().getToken().then((value) {
      if (value.isNotEmpty) {
        AccountModel account = AccountModel.fromJson(jsonDecode(value));
        options.headers["Authorization"] = "Bearer ${account.accessToken}";
      }
      handler.next(options);
    });
  }
}
