import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/user_api.dart';

import '../../domain/repositoties/user_repo.dart';
import '../models/list_user_model.dart';

class UserRepoImpl implements UserRepo {
  final userAPI = Get.find<UserAPI>();
  @override
  Future<ListUserModel> getUserData() async {
    final listUser = await userAPI.getUserData();
    return listUser;
  }
}
