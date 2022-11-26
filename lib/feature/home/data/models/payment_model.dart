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
}
