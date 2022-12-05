import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/payment_model.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: true)
class ListPaymentModel {
  List<dynamic>? data;

  ListPaymentModel({this.data});
}
