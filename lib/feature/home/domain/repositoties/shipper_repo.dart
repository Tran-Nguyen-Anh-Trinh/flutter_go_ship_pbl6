import 'package:flutter_go_ship_pbl6/feature/home/data/models/order_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/shipper_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/receive_order_request.dart';

import '../../data/providers/remote/request/shipper_request.dart';

abstract class ShipperRepo {
  Future<ShipperModel> getShipperInfo();
  Future<OrderModel> getOrderById(int id);
  Future<void> receiveOrder(StatusOrderRequest request);
  Future<void> deliveryOrder(StatusOrderRequest request);
  // Future<void> confirmDoneOrder(StatusOrderRequest request);
  Future<ShipperModel?> updateShipperInfo(ShipperRequest request);
  Future<void> requestConfirmDoneOrder(StatusOrderRequest request);
  Future<void> deleteOrder(int request);
}
