import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:intl/intl.dart';

class Messages {
  Messages({
    this.messages,
    this.image,
    required this.dateTime,
    required this.senderPhone,
  });
  String? messages;
  String? image;
  DateTime dateTime;
  String senderPhone;

  factory Messages.fromJson(Map<dynamic, dynamic> json) {
    final dateTimeConvert =
        DateFormat(AppConfig.formatDateTime).parse(json['dateTime']);
    return Messages(
      messages: json['messages'],
      image: json['image'],
      dateTime: dateTimeConvert,
      senderPhone: json['senderPhone'],
    );
  }

  Map<String, dynamic> toJson() {
    final formattedDate = DateFormat(AppConfig.formatDateTime).format(dateTime);
    return {
      'messages': messages,
      'image': image,
      'dateTime': formattedDate,
      'senderPhone': senderPhone,
    };
  }
}
