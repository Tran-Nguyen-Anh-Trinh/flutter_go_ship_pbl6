import 'package:flutter_go_ship_pbl6/feature/home/data/models/category_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/customer_info_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/repositoties/customer_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class GetCustomeInfoUsecase extends UseCase<CustomerModel> {
  GetCustomeInfoUsecase(this._customerRepo);
  final CustomerRepo _customerRepo;

  @override
  Future<CustomerModel> build() {
    return _customerRepo.getCustomerInfo();
  }
}
