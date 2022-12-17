import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/category_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/customer_info_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/payment_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/price_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/customer_api.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/create_order_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/get_price_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/receive_order_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/repositoties/customer_repo.dart';

import '../providers/remote/request/customer_request.dart';

class CustomerRepoImpl implements CustomerRepo {
  final _customerAPI = Get.find<CustomerAPI>();

  @override
  Future<List<CategoryModel>> getCategory() async {
    var listCategory = await _customerAPI.getCategory();
    return listCategory.data?.map((paymentModel) => CategoryModel.fromJson(paymentModel)).toList() ?? [];
  }

  @override
  Future<List<PaymentModel>> getPayment() async {
    var listPayment = await _customerAPI.getPayment();
    return listPayment.data?.map((paymentModel) => PaymentModel.fromJson(paymentModel)).toList() ?? [];
  }

  @override
  Future<void> createOrder(CreateOrderRequest request) {
    return _customerAPI.createOrder(request);
  }

  @override
  Future<CustomerModel> getCustomerInfo() {
    return _customerAPI.getCustomerInfo();
  }

  @override
  Future<CustomerModel?> updateCustomerInfo(CustomerRequest request) {
    return _customerAPI.updateCustomerInfo(request);
  }

  @override
  Future<PriceModel> getPrice(GetPriceRequest request) {
    return _customerAPI.getPrice(request);
  }
}
