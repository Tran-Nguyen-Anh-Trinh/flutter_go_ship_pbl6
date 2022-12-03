import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/account_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/category_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/payment_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/shipper_model.dart';

import '../../feature/home/data/models/customer_info_model.dart';

class AppConfig {
  static const baseUrl = 'http://167.71.197.115:8000/api/v1/';
  static const keyToken = 'token';
  static const googleApiKeyView = "AIzaSyD46blEqiLXMyG-i9A8nznacxW-AkIlfCg";
  static const googleApiKeySearch = "AIzaSyB4sfadiVrHjkVPONVpLTLTwWnCaaWq6ok";
  static const openrouteApiKeyDirections = "5b3ce3597851110001cf62484f65c4b2035549f28529cc860cb74c3c";
  static AccountModel accountModel = AccountModel();
  static CustomerModel customerInfo = CustomerModel();
  static ShipperModel shipperModel = ShipperModel();
  static List<CategoryModel> listCategory = [];
  static List<PaymentModel> listPayment = [];
  static const formatDateTime = 'dd-MM-yyyy kk:mm:ss';
}
