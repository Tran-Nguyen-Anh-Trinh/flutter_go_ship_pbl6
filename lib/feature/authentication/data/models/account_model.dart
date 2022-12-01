import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false, name: 'data')
class AccountModel {
  String? phoneNumber;

  String? accessToken;

  String? refreshToken;

  int? role;

  AccountModel(
      {this.phoneNumber, this.accessToken, this.refreshToken, this.role});

  Map<String, dynamic> toJson() {
    return {
      '"phoneNumber"': '"$phoneNumber"',
      '"accessToken"': '"$accessToken"',
      '"refreshToken"': '"$refreshToken"',
      '"role"': role,
    };
  }

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      phoneNumber: json['phoneNumber'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      role: json['role'],
    );
  }
}
