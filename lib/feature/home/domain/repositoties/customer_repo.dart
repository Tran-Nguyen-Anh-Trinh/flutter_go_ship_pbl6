import 'package:flutter_go_ship_pbl6/feature/home/data/models/category_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/customer_info_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/list_order_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/payment_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/price_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/rate_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/shipper_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/create_order_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/customer_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/get_price_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/receive_order_request.dart';

abstract class CustomerRepo {
  Future<List<CategoryModel>> getCategory();
  Future<List<PaymentModel>> getPayment();
  Future<void> createOrder(CreateOrderRequest request);
  Future<CustomerModel> getCustomerInfo();
  Future<CustomerModel?> updateCustomerInfo(CustomerRequest request);
  Future<PriceModel> getPrice(GetPriceRequest request);
  Future<ListOrdersModel> getOrders(int page);
  Future<ListOrdersModel> getOrdersWithStatus(int page, int statusID);
  Future<ShipperModel> getShipperInfoWithID(int id);
  Future<void> confirmOrder(StatusOrderRequest request);
  Future<void> rateOrder(RateOrderRequest request);
  Future<RateModel> getRateOrderDetail(int orderID);
}
