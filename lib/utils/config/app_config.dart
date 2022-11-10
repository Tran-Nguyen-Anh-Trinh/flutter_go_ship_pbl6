import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/account_model.dart';

class AppConfig {
  static const baseUrl = 'https://go-ship.herokuapp.com/api/v1/';
  static const keyToken = 'token';
  static const googleApiKeyView = "AIzaSyD46blEqiLXMyG-i9A8nznacxW-AkIlfCg";
  static const googleApiKeySearch = "AIzaSyB4sfadiVrHjkVPONVpLTLTwWnCaaWq6ok";
  static const openrouteApiKeyDirections = "5b3ce3597851110001cf62484f65c4b2035549f28529cc860cb74c3c";
  static late final AccountModel accountModel;
  static const formatDateTime = 'dd-MM-yyyy kk:mm:ss';
}
