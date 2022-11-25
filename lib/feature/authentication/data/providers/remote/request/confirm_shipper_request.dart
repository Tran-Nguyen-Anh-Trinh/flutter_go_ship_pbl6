import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/shipper_model.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false)
class ConfirmShipperRequest {
  String? name;
  int? gender;
  AddressModel? address;
  String? urlIdentificationTop;
  String? urlIdentificationBack;
  String? identificationInfo;
  String? urlFaceVideo;

  ConfirmShipperRequest(
    this.name,
    this.gender,
    this.address,
    this.urlIdentificationTop,
    this.urlIdentificationBack,
    this.identificationInfo,
    this.urlFaceVideo,
  );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gender': gender,
      'address': address?.toJsonNonID(),
      'url_identification_top': urlIdentificationTop,
      'url_identification_back': urlIdentificationBack,
      'identification_info': identificationInfo,
      'url_face_video': urlFaceVideo,
    };
  }
}
