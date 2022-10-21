import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import '../interceptor/header_interceptor.dart';

class DioBuilder extends DioMixin implements Dio {
  final String contentType = 'application/json';
  final int connectionTimeOutMls = 30000;
  final int readTimeOutMls = 30000;
  final int writeTimeOutMls = 30000;

  DioBuilder({required BaseOptions options}) {
    options = BaseOptions(
      baseUrl: options.baseUrl,
      contentType: contentType,
      connectTimeout: connectionTimeOutMls,
      receiveTimeout: readTimeOutMls,
      sendTimeout: writeTimeOutMls,
    );

    this.options = options;
    interceptors.add(HeaderInterceptor());

    httpClientAdapter = DefaultHttpClientAdapter();
  }
}
