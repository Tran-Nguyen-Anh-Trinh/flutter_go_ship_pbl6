import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false)
class AccountModel {
  String? phoneNumber;

  String? accessToken;

  int? role;

  AccountModel({this.phoneNumber, this.accessToken, this.role});

  Map<String, dynamic> toJson() {
    return {
      '"phoneNumber"': '"$phoneNumber"',
      '"accessToken"': '"$accessToken"',
      '"role"': role,
    };
  }

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      phoneNumber: json['phoneNumber'],
      accessToken: json['accessToken'],
      role: json['role'],
    );
  }
}
