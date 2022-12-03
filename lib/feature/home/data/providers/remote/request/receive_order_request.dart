import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false)
class ReceiveOrderRequest {
  int? orderId;

  ReceiveOrderRequest(
    this.orderId,
  );

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
    };
  }
}
