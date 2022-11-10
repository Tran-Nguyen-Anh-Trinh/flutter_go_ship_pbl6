import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/utils/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageServiceImpl implements StorageService {
  final _sharedPreferences = SharedPreferences.getInstance();
  @override
  Future<void> setToken(String token) async {
    (await _sharedPreferences).setString(AppConfig.keyToken, token);
  }

  @override
  Future<String> getToken() async {
    return (await _sharedPreferences).getString(AppConfig.keyToken) ?? "";
  }

  @override
  Future<void> removeToken() async {
    (await _sharedPreferences).remove(AppConfig.keyToken);
  }
}
