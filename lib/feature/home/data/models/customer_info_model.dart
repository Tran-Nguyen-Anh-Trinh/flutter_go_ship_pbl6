import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false)
class AddressModel {
  int? id;
  String? addressNotes;
  String? latitude;
  String? longitude;

  AddressModel({
    this.id,
    this.addressNotes,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address_notes': addressNotes,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false, name: 'data')
class CustomerModel {
  String? name;
  AddressModel? address;
  int? gender;
  String? avatarUrl;
  String? birthDate;
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
      'birth_date': birthDate,
      'distance_view': distanceView,
    };
  }
}
