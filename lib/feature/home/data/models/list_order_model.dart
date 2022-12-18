import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: true)
class ListOrderDataModel {
  ListOrdersModel? data;

  ListOrderDataModel({this.data});
}

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: true)
class ListOrdersModel {
  List<dynamic>? orders;
  int? numPages;
  int? total;
  ListOrdersModel({this.orders, this.numPages, this.total});
}
