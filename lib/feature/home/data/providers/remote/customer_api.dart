import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/list_category_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/list_order_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/list_payment_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/list_rate_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/price_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/rate_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/shipper_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/create_order_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/customer_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/get_price_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/receive_order_request.dart';
import 'package:retrofit/http.dart';

import '../../models/customer_info_model.dart';

part 'customer_api.g.dart';

@RestApi(parser: Parser.DartJsonMapper)
abstract class CustomerAPI {
  factory CustomerAPI(Dio dioBuilder) = _CustomerAPI;

  @GET('/category/')
  Future<ListCategoryModel> getCategory();

  @GET('/payment/')
  Future<ListPaymentModel> getPayment();

  @POST('/order/')
  Future<void> createOrder(@Body() CreateOrderRequest request);

  @GET('/order/')
  Future<ListOrderDataModel> getOrders(@Query("page") page);

  @GET('/order/status/')
  Future<ListOrderDataModel> getOrdersWithStatus(@Query("page") page, @Query("status_id") statusID);

  @PATCH('/order/confirm-done/')
  Future<void> confirmOrder(@Body() StatusOrderRequest request);

  @POST('/order/rate/')
  Future<void> rateOrder(@Body() RateOrderRequest request);

  @GET('/order/{order_id }/rate-detail/')
  Future<RateModel> getRateOrderDetail(@Path("order_id ") int orderID);

  @GET('/customer/detail/')
  Future<CustomerModel> getCustomerInfo();

  @PUT('/customer/detail/')
  Future<CustomerModel?> updateCustomerInfo(@Body() CustomerRequest request);

  @GET('/distance/get_price/')
  Future<PriceModel> getPrice(@Query("distance") double distance, @Query("is_protected") int isProtected);

  @GET('shipper/{shipper_id}/info/')
  Future<ShipperModel> getShipperInfoWithID(@Path("shipper_id") id);

   @GET('shipper/{shipper_id}/list-rate-detail/')
  Future<ListRateModel> getShipperRatesWithID(@Path("shipper_id") id);
}
