import 'package:flutter_go_ship_pbl6/feature/home/data/models/category_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/repositoties/customer_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class GetCategoryUsecase extends UseCase<List<CategoryModel>> {
  GetCategoryUsecase(this._customerRepo);
  final CustomerRepo _customerRepo;

  @override
  Future<List<CategoryModel>> build() {
    return _customerRepo.getCategory();
  }
}
