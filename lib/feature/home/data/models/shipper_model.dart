import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false, name: "data")
class ShipperModel {
  String? shipperId;
  String? name;
  int? gender;
  String? avatarUrl;
  DateTime? birthDate;
  String? urlIdentificationTop;
  String? urlIdentificationBack;
  String? identificationInfo;
  String? urlFaceVideo;
  int? confirmed;
  int? distanceReceive;
  AddressModel? address;

  ShipperModel({
    this.shipperId,
    this.name,
    this.gender,
    this.avatarUrl,
    this.birthDate,
    this.urlIdentificationTop,
    this.urlIdentificationBack,
    this.identificationInfo,
    this.urlFaceVideo,
    this.confirmed,
    this.distanceReceive,
    this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      '"shipperId"': '"$shipperId"',
      '"name"': '"$name"',
      '"gender"': gender,
      '"avatarUrl"': '"${avatarUrl ?? ''}"',
      '"birthDate"': '"${birthDate ?? DateTime(2022)}"',
      '"urlIdentificationTop"': '"${urlIdentificationTop ?? ''}"',
      '"urlIdentificationBack"': '"${urlIdentificationBack ?? ''}"',
      '"identificationInfo"': '"${identificationInfo ?? ''}"',
      '"urlFaceVideo"': '"${urlFaceVideo ?? ''}"',
      '"confirmed"': confirmed,
      '"distanceReceive"': distanceReceive,
      '"address"':
          address != null ? address!.toJson() : AddressModel().toJson(),
    };
  }

  factory ShipperModel.fromJson(Map<String, dynamic> json) {
    return ShipperModel(
      shipperId: json['shipperId'],
      name: json['name'],
      gender: json['gender'],
      avatarUrl: json['avatarUrl'],
      birthDate: DateTime.parse(json['birthDate']),
      urlIdentificationTop: json['urlIdentificationTop'],
      urlIdentificationBack: json['urlIdentificationBack'],
      identificationInfo: json['identificationInfo'],
      urlFaceVideo: json['urlFaceVideo'],
      confirmed: json['confirmed'],
      distanceReceive: json['distanceReceive'],
      address: AddressModel.fromJson(json['address']),
    );
  }
}

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false)
class AddressModel {
  int? id;
  String? addressNotes;
  String? latitude;
  String? longitude;

  AddressModel({
    this.id = -1,
    this.addressNotes,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      '"id"': id,
      '"addressNotes"': '"${addressNotes ?? ''}"',
      '"latitude"': '"${latitude ?? ''}"',
      '"longitude"': '"${longitude ?? ''}"',
    };
  }

  Map<String, dynamic> toJsonNonID() {
    return {
      'address_notes': addressNotes,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      addressNotes: json['address_notes'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

//   {
//     "shipper_id": "0777333765",
//     "address": {
//         "id": 7,
//         "address_notes": "Hue",
//         "latitude": "103.1",
//         "longitude": "18"
//     },
//     "name": "Huy",
//     "gender": 1,
//     "latitude": null,
//     "longitude": null,
//     "url_identification_top": "string",
//     "url_identification_back": "string",
//     "identification_info": null,
//     "url_face_video": "string",
//     "confirmed": 0,
//     "distance_receive": 10
// }
