import 'package:flutter_go_ship_pbl6/feature/home/data/models/category_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/payment_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/repositoties/customer_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class GetPaymentUsecase extends UseCase<List<PaymentModel>> {
  GetPaymentUsecase(this._customerRepo);
  final CustomerRepo _customerRepo;

  @override
  Future<List<PaymentModel>> build() {
    return _customerRepo.getPayment();
  }
}
