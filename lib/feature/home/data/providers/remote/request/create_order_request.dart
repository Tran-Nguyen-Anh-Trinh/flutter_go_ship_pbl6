import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/shipper_model.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false)
class CreateOrderRequest {
  AddressModel? addressStart;
  AddressModel? addressEnd;
  String? description;
  double? distance;
  String? customerNotes;
  String? imgOrder;
  int? payment;
  int? category;

  CreateOrderRequest(
    this.addressStart,
    this.addressEnd,
    this.description,
    this.distance,
    this.customerNotes,
    this.imgOrder,
    this.payment,
    this.category,
  );

  Map<String, dynamic> toJson() {
    return {
      'address_start': addressStart?.toJsonNonID(),
      'address_end': addressEnd?.toJsonNonID(),
      'description': description,
      'distance': distance,
      'customer_notes': customerNotes,
      'img_order': imgOrder,
      'payment': payment,
      'category': category,
    };
  }
}
