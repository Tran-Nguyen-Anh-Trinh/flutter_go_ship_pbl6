import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false)
class CategoryModel {
  int? id;
  String? name;
  bool? isProtected;

  CategoryModel({
    this.id,
    this.name,
    this.isProtected,
  });
}
