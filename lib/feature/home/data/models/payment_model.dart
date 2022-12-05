import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false)
class PaymentModel {
  int? id;
  String? type;
  String? description;

  PaymentModel({
    this.id,
    this.type,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'description': description,
    };
  }

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'],
      type: json['type'],
      description: json['description'],
    );
  }
}
