import 'package:flutter_go_ship_pbl6/feature/home/data/models/category_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/payment_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/create_order_request.dart';

abstract class CustomerRepo {
  Future<List<CategoryModel>> getCategory();
  Future<List<PaymentModel>> getPayment();
  Future<void> createOrder(CreateOrderRequest request);
}
