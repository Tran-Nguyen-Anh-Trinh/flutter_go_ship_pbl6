import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../../../models/shipper_model.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false, name: "data")
class ShipperRequest {
  String? avatarUrl;
  int? distanceReceive;

  ShipperRequest({
    this.avatarUrl,
    this.distanceReceive,
  });

  Map<String, dynamic> toJson() {
    return {
      'avatar_url': avatarUrl,
      'distance_receive': distanceReceive,
    };
  }
}
