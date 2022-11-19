
import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: true)
class InforUser {
  InforUser({this.phone, this.name, this.avatar});
  String? phone;
  String? name;
  String? avatar;

  // factory InforUser.fromJson(Map<dynamic, dynamic> json) => InforUser(
  //       phone: json['phone'],
  //       name: json['name'],
  //     );
}
