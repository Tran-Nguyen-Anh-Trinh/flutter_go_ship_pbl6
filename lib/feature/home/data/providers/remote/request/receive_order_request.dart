import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false)
class StatusOrderRequest {
  int? orderId;

  StatusOrderRequest(
    this.orderId,
  );

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
    };
  }
}

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false)
class RateOrderRequest {
  int? orderId;
  String? feedback;
  int? rate;

  RateOrderRequest(
    this.orderId,
    this.feedback,
    this.rate,
  );

  Map<String, dynamic> toJson() {
    return {
      'order': orderId,
      'rate': rate,
      'feedback': feedback,
    };
  }
}
