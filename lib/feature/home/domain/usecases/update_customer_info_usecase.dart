import 'package:flutter_go_ship_pbl6/base/domain/base_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/repositoties/customer_repo.dart';

import '../../data/models/customer_info_model.dart';

class UpdateCustomerInfoUsecase extends UseCaseIO<CustomerModel, void> {
  UpdateCustomerInfoUsecase(this._customerRepo);
  CustomerRepo _customerRepo;

  @override
  Future<void> build(CustomerModel input) {
    return _customerRepo.updateCustomerInfo(input);
  }
}
