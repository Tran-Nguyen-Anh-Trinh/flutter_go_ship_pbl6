abstract class StorageService {
  Future<void> setToken(String token);
  Future<String> getToken(); 
  Future<void> removeToken();
}