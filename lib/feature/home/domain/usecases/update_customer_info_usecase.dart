import 'package:flutter_go_ship_pbl6/base/domain/base_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/repositoties/customer_repo.dart';

import '../../data/models/customer_info_model.dart';
import '../../data/providers/remote/request/customer_request.dart';

class UpdateCustomerInfoUsecase extends UseCaseIO<CustomerRequest, CustomerModel?> {
  UpdateCustomerInfoUsecase(this._customerRepo);
  CustomerRepo _customerRepo;

  @override
  Future<CustomerModel?> build(CustomerRequest input) {
    return _customerRepo.updateCustomerInfo(input);
  }
}
