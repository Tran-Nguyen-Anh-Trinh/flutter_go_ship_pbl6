import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false)
class ShipperLocation {
  String? phoneNumber;
  String? latitude;
  String? longitude;

  ShipperLocation({
    this.phoneNumber,
    this.latitude,
    this.longitude,
  });

  factory ShipperLocation.fromJson(Map<dynamic, dynamic> json, String? phoneNumber) {
    return ShipperLocation(
      phoneNumber: phoneNumber,
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
