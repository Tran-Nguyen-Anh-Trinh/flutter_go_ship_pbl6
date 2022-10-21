
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/user_model.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: true, name: 'data')
class ListUserModel {
  List<UserModel>? listUserModel;

  ListUserModel({this.listUserModel});

  factory ListUserModel.fromJson(Map<String, dynamic> json) {
    return ListUserModel(
      listUserModel: List<UserModel>.from(json["data"].map((x) => UserModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'listUserModel': listUserModel?.first.toJson(),
    };
  }
}
