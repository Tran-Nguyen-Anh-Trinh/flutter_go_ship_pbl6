import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false)
class NotificationModel {
  String? title;
  String? body;
  OrderDataNotificationModel? data;
  bool? isSeen;

  NotificationModel({
    this.title,
    this.body,
    this.data,
    this.isSeen,
  });

  factory NotificationModel.fromJson(Map<dynamic, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      body: json['body'],
      isSeen: json['seen'],
      data: OrderDataNotificationModel.fromJson(json['data']),
    );
  }
}

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false)
class OrderDataNotificationModel {
  int? orderID;
  int? type;
  String? time;

  OrderDataNotificationModel({
    this.orderID,
    this.type,
    this.time,
  });

  factory OrderDataNotificationModel.fromJson(Map<dynamic, dynamic> json) {
    return OrderDataNotificationModel(
      orderID: int.parse(json['order_id']),
      type: int.parse(json['type']),
      time: json['time'],
    );
  }
}
