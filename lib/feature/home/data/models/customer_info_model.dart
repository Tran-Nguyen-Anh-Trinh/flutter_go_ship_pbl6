import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/shipper_model.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false, name: 'data')
class CustomerModel {
  String? name;
  AddressModel? address;
  int? gender;
  String? avatarUrl;
  DateTime? birthDate;
  int? distanceView;

  CustomerModel({
    this.name,
    this.address,
    this.avatarUrl,
    this.gender,
    this.birthDate,
    this.distanceView,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address?.toJson(),
      'avatar_url': avatarUrl,
      'gender': gender,
      '"birth_date"': '"${birthDate ?? DateTime(2022)}"',
      'distance_view': distanceView,
    };
  }
}
