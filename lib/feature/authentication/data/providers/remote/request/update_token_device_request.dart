import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false)
class UpdateTokenDeviceRequest {
  String? token;

  UpdateTokenDeviceRequest(this.token);

  Map<String, dynamic> toJson() {
    return {
      'token_device': token,
    };
  }
}
