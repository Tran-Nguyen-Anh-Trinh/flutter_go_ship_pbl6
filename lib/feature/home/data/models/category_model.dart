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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'is_protected': isProtected,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      isProtected: json['is_protected'],
    );
  }
}
