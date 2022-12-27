import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false, name: "data")
class ListRateModel {
  double? mean;
  List<dynamic>? rates;

  ListRateModel({
    this.mean,
    this.rates,
  });
}
