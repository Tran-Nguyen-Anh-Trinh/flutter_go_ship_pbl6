import '../../../../base/domain/base_usecase.dart';
import '../../data/models/list_user_model.dart';
import '../repositoties/user_repo.dart';

class GetDataUserUsecase extends UseCase<ListUserModel> {
  GetDataUserUsecase(this.userRepo);
  final UserRepo userRepo;

  @override
  Future<ListUserModel> build() {
    return userRepo.getUserData();
  }
}
