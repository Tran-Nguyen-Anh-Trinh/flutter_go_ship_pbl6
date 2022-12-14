import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/category_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/payment_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/shipper_model.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false, name: "data")
class OrderModel {
  int? id;
  AddressModel? addressStart;
  AddressModel? addressEnd;
  String? description;
  dynamic cost;
  dynamic distance;
  DateTime? createdAt;
  String? customerNotes;
  String? imgOrder;
  CustomerOrderModel? customer;
  int? shipper;
  PaymentModel? payment;
  CategoryModel? category;
  StatusModel? status;
  int? paymentID;
  int? categoryID;
  int? statusID;
  bool? isRating;

  OrderModel({
    this.id,
    this.addressStart,
    this.addressEnd,
    this.description,
    this.cost,
    this.distance,
    this.createdAt,
    this.customerNotes,
    this.imgOrder,
    this.customer,
    this.shipper,
    this.payment,
    this.category,
    this.status,
    this.paymentID,
    this.categoryID,
    this.statusID,
    this.isRating,
  });

  Map<String, dynamic> toJson() {
    return {
      '"id"': id,
      '"addressStart"': addressStart != null ? addressStart!.toJson() : AddressModel().toJson(),
      '"addressEnd"': addressEnd != null ? addressEnd!.toJson() : AddressModel().toJson(),
      '"description"': '"${description ?? ''}"',
      '"createdAt"': '"${createdAt ?? DateTime(2022)}"',
      '"cost"': cost,
      '"distance"': distance,
      '"shipper"': shipper,
      '"imgOrder"': '"${imgOrder ?? ''}"',
      '"payment"': payment,
      '"status"': status,
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      description: json['description'],
      cost: json['cost'],
      distance: json['distance'],
      createdAt: DateTime.parse(json['created_at']),
      customerNotes: json['customer_notes'],
      imgOrder: json['img_order'],
      shipper: json['shipper'],
      addressStart: AddressModel.fromJson(json['address_start']),
      addressEnd: AddressModel.fromJson(json['address_end']),
    );
  }
}

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false)
class CustomerOrderModel {
  AccountModel? account;
  String? name;
  int? gender;
  String? avatarUrl;
  DateTime? birthDate;
  int? distanceView;

  CustomerOrderModel({
    this.account,
    this.avatarUrl,
    this.birthDate,
    this.distanceView,
    this.gender,
    this.name,
  });
}

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false)
class StatusModel {
  int? id;
  String? title;
  String? description;
}

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: false)
class AccountModel {
  String? phoneNumber;

  AccountModel({this.phoneNumber});
}
