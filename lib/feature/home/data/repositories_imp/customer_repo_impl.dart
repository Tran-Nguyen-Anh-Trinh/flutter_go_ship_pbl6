import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/category_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/payment_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/customer_api.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/create_order_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/repositoties/customer_repo.dart';

class CustomerRepoImpl implements CustomerRepo {
  final _customerAPI = Get.find<CustomerAPI>();

  @override
  Future<List<CategoryModel>> getCategory() {
    return _customerAPI.getCategory();
  }

  @override
  Future<List<PaymentModel>> getPayment() {
    return _customerAPI.getPayment();
  }

  @override
  Future<void> createOrder(CreateOrderRequest request) {
    return _customerAPI.createOrder(request);
  }
}
