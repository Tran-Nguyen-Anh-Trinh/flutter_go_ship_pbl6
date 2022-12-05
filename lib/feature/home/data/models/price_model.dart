import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false, name: "data")
class PriceModel {
  dynamic money;
  dynamic extraPrice;
  dynamic total;

  PriceModel({
    this.money,
    this.extraPrice,
    this.total,
  });
}
