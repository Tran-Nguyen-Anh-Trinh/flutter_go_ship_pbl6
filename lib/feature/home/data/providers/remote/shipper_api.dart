import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/shipper_model.dart';
import 'package:retrofit/http.dart';

part 'shipper_api.g.dart';

@RestApi(parser: Parser.DartJsonMapper)
abstract class ShipperAPI {
  factory ShipperAPI(Dio dioBuilder) = _ShipperAPI;

  @GET('/shipper/detail/')
  Future<ShipperModel> getShipperInfo();
}
