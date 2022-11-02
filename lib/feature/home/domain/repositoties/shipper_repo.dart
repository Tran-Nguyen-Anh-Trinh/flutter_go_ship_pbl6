import 'package:flutter_go_ship_pbl6/feature/home/data/models/shipper_model.dart';


abstract class ShipperRepo {
  Future<ShipperModel> getShipperInfo();
}
