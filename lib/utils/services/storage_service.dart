abstract class StorageService {
  Future<void> setToken(String token);
  Future<String> getToken();
  Future<void> removeToken();
  Future<void> setSearchHistory(List<String> historys);
  Future<List<String>> getSearchHistory();
  Future<void> removeSearchHistory();
  Future<void> setShipper(String shipper);
  Future<String> getShipper();
  Future<void> removeShipper();
}
