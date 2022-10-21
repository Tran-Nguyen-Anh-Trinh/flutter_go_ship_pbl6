import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: true, name: 'data')
class User {
  int? id;
  String? name;
  String? email;
  String? gender;
  String? status;
}
