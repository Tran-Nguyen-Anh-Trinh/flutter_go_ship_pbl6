import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/utils/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageServiceImpl implements StorageService {
  final _sharedPreferences = SharedPreferences.getInstance();

  final _kSearchHistory = "searchHistory";

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

  @override
  Future<void> setSearchHistory(List<String> historys) async {
    (await _sharedPreferences).setStringList(_kSearchHistory, historys);
  }

  @override
  Future<List<String>> getSearchHistory() async {
    return (await _sharedPreferences).getStringList(_kSearchHistory) ?? <String>[];
  }

  @override
  Future<void> removeSearchHistory() async {
    (await _sharedPreferences).remove(_kSearchHistory);
  }
}
