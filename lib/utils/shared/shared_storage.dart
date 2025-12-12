abstract class SharedStorage {
  // * MARK: Token

  Future<String?> getToken();
  Future<bool> saveToken(String token);
  Future<bool> deleteToken();

  // * MARK: Refresh token

  Future<bool> saveRefreshToken(String token);
  Future<String?> getRefreshToken();
  Future<bool> deleteRefreshToken();

  // * MARK: Authorization

  Future<bool> setAuthorized(bool value);
  Future<bool> isAuthorized();
  Future<void> clearAuthData();
}
