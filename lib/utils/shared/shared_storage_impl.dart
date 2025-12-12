import 'package:shared_preferences/shared_preferences.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';

class SharedStorageImpl implements SharedStorage {
  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  // * MARK: Token

  @override
  Future<String?> getToken() async {
    final prefs = await _getPrefs();
    return prefs.getString('jwt_token');
  }

  @override
  Future<bool> saveToken(String token) async {
    final prefs = await _getPrefs();
    return prefs.setString('jwt_token', token.replaceAll(RegExp('"'), ''));
  }

  @override
  Future<bool> deleteToken() async {
    final prefs = await _getPrefs();
    return prefs.remove('jwt_token');
  }

  // * MARK: Refresh token

  Future<bool> saveRefreshToken(String token) async {
    final prefs = await _getPrefs();
    return prefs.setString(
      'refresh_jwt_token',
      token.replaceAll(RegExp('"'), ''),
    );
  }

  Future<String?> getRefreshToken() async {
    final prefs = await _getPrefs();
    return prefs.getString('refresh_jwt_token');
  }

  Future<bool> deleteRefreshToken() async {
    final prefs = await _getPrefs();
    return prefs.remove('refresh_jwt_token');
  }

  // * MARK: Authorization

  Future<bool> setAuthorized(bool value) async {
    final prefs = await _getPrefs();
    return prefs.setBool('isAuthorized', value);
  }

  Future<bool> isAuthorized() async {
    final prefs = await _getPrefs();
    return prefs.getBool('isAuthorized') ?? false;
  }

  Future<void> clearAuthData() async {
    await deleteToken();
    await deleteRefreshToken();
  }
}
