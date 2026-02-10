abstract class SharedStorage {
  // * MARK: Token

  Future<String?> getToken();
  Future<bool> saveToken(String token);
  Future<bool> deleteToken();

  // * MARK: Refresh token

  Future<bool> saveRefreshToken(String token);
  Future<String?> getRefreshToken();
  Future<bool> deleteRefreshToken();

  // // * MARK: Authorization

  // Future<bool> setAuthorized(bool value);
  // Future<bool> isAuthorized();
  // Future<void> clearAuthData();

  // * MARK: Locale

  Future<bool> setLocale(String value);
  Future<String?> getLocale();

  // * MARK: Them

  Future<bool?> setThemeIsDark(bool? value);
  Future<bool?> getThemeIsDark();

  // * MARK: Onboarding

  Future<bool> setShowOnboarding();
  Future<bool> isShowOnboarding();

  // * MARK: Favourites

  Future<List<String>> getFavoriteIds();
  Future<bool> addFavoriteId(String id);
  Future<bool> removeFavoriteId(String id);

  // * MARK: Viewed

  Future<List<String>> getViewedIds();
  Future<bool> addViewedId(String id);
  Future<bool> removeViewedId(String id);
}
