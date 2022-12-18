import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false)
class GetPriceRequest {
  double? distance;
  int? isProtected;

  GetPriceRequest(
    this.distance,
    this.isProtected,
  );

  Map<String, dynamic> toJson() {
    return {
      'distance': distance,
      'is_protected': isProtected,
    };
  }
}
