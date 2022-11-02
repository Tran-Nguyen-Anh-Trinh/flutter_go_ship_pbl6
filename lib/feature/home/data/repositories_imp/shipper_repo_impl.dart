import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/shipper_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/shipper_api.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/repositoties/shipper_repo.dart';

class ShipperRepoImpl implements ShipperRepo {
  final _shipperAPI = Get.find<ShipperAPI>();

  @override
  Future<ShipperModel> getShipperInfo() {
    return _shipperAPI.getShipperInfo();
  }
}
