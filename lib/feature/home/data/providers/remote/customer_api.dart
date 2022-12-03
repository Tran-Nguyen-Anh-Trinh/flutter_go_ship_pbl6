import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/category_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/payment_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/create_order_request.dart';
import 'package:retrofit/http.dart';

import '../../models/customer_info_model.dart';

part 'customer_api.g.dart';

@RestApi(parser: Parser.DartJsonMapper)
abstract class CustomerAPI {
  factory CustomerAPI(Dio dioBuilder) = _CustomerAPI;

  @GET('/category/')
  Future<List<CategoryModel>> getCategory();

  @GET('/payment/')
  Future<List<PaymentModel>> getPayment();

  @POST('/order/')
  Future<void> createOrder(@Body() CreateOrderRequest request);

  @GET('/customer/detail/')
  Future<CustomerModel> getCustomerInfo();

  @PUT('/customer/detail/')
  Future<void> updateCustomerInfo(@Body() CustomerModel request);
}
