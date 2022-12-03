import 'package:flutter_go_ship_pbl6/feature/home/data/models/category_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/customer_info_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/payment_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/price_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/create_order_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/get_price_request.dart';

abstract class CustomerRepo {
  Future<List<CategoryModel>> getCategory();
  Future<List<PaymentModel>> getPayment();
  Future<void> createOrder(CreateOrderRequest request);
  Future<CustomerModel> getCustomerInfo();
  Future<void> updateCustomerInfo(CustomerModel request);
  Future<PriceModel> getPrice(GetPriceRequest request);
}
