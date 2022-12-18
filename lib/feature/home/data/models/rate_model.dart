import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false, name: "data")
class RateModel {
  int? id;
  String? feedback;
  int? rate;
  int? order;

  RateModel({
    this.id,
    this.feedback,
    this.rate,
    this.order,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'feedback': feedback,
      'rate': rate,
      'order': order,
    };
  }

  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(
      id: json['id'],
      feedback: json['feedback'],
      rate: json['rate'],
      order: json['order'],
    );
  }
}
