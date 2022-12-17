import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/order_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/shipper_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/receive_order_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/shipper_api.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/repositoties/shipper_repo.dart';

import '../providers/remote/request/shipper_request.dart';

class ShipperRepoImpl implements ShipperRepo {
  final _shipperAPI = Get.find<ShipperAPI>();

  @override
  Future<ShipperModel> getShipperInfo() {
    return _shipperAPI.getShipperInfo();
  }

  @override
  Future<OrderModel> getOrderById(int id) {
    return _shipperAPI.getOrderById(id);
  }

  @override
  Future<void> receiveOrder(StatusOrderRequest request) {
    return _shipperAPI.receiveOrder(request);
  }

  @override
  Future<void> deliveryOrder(StatusOrderRequest request) {
    return _shipperAPI.deliveryOrder(request);
  }

  @override
  Future<void> confirmDoneOrder(StatusOrderRequest request) {
    return _shipperAPI.confirmDoneOrder(request);
  }
  
  @override
  Future<ShipperModel?> updateShipperInfo(ShipperRequest request) {
    return _shipperAPI.updateShipperInfo(request);
  }
}
