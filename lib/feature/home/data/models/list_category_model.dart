import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false)
class ListCategoryModel {
  List<dynamic>? data;

  ListCategoryModel({
    this.data,
  });
}
