import '../../data/models/list_user_model.dart';

abstract class UserRepo {
   Future<ListUserModel> getUserData();
}