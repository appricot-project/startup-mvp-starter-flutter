import 'package:flutter/material.dart';
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

  // // * MARK: Authorization

  // Future<bool> setAuthorized(bool value) async {
  //   final prefs = await _getPrefs();
  //   return prefs.setBool('isAuthorized', value);
  // }

  // Future<bool> isAuthorized() async {
  //   final prefs = await _getPrefs();
  //   return prefs.getBool('isAuthorized') ?? false;
  // }

  // Future<void> clearAuthData() async {
  //   await deleteToken();
  //   await deleteRefreshToken();
  // }

  // * MARK: Locale

  Future<bool> setLocale(String? value) async {
    final prefs = await _getPrefs();
    if (value != null) {
      return prefs.setString('locale', value);
    } else {
      return prefs.remove('locale');
    }
  }

  Future<String?> getLocale() async {
    final prefs = await _getPrefs();
    return prefs.getString("locale");
  }

  // * MARK: Them

  Future<void> setTheme(ThemeMode value) async {
    final prefs = await _getPrefs();
    await prefs.setString('theme', value.name);
  }

  Future<ThemeMode> getTheme() async {
    final prefs = await _getPrefs();
    final themeString = prefs.getString('theme');

    return ThemeMode.values.firstWhere(
      (e) => e.name == themeString,
      orElse: () => ThemeMode.system,
    );
  }

  // * MARK: Onboarding

  Future<bool> setShowOnboarding() async {
    final prefs = await _getPrefs();
    return prefs.setBool('onboarding', true);
  }

  Future<bool> isShowOnboarding() async {
    final prefs = await _getPrefs();
    return prefs.getBool('onboarding') ?? false;
  }

  // * MARK: Favourites

  Future<List<String>> getFavoriteIds() async {
    final prefs = await _getPrefs();
    return prefs.getStringList('favorite_ids') ?? [];
  }

  Future<bool> addFavoriteId(String id) async {
    final prefs = await _getPrefs();
    final favoriteIds = prefs.getStringList('favorite_ids') ?? [];
    if (!favoriteIds.contains(id)) {
      favoriteIds.add(id);
    }
    return prefs.setStringList('favorite_ids', favoriteIds);
  }

  Future<bool> removeFavoriteId(String id) async {
    final prefs = await _getPrefs();
    final favoriteIds = prefs.getStringList('favorite_ids') ?? [];
    favoriteIds.remove(id);
    return prefs.setStringList('favorite_ids', favoriteIds);
  }

  // * MARK: Viewed

  Future<List<String>> getViewedIds() async {
    final prefs = await _getPrefs();
    return prefs.getStringList('viewed_ids') ?? [];
  }

  Future<bool> addViewedId(String id) async {
    final prefs = await _getPrefs();
    final viewedIds = prefs.getStringList('viewed_ids') ?? [];
    if (!viewedIds.contains(id)) {
      viewedIds.add(id);
    }
    return prefs.setStringList('viewed_ids', viewedIds);
  }

  Future<bool> removeViewedId(String id) async {
    final prefs = await _getPrefs();
    final viewedIds = prefs.getStringList('viewed_ids') ?? [];
    viewedIds.remove(id);
    return prefs.setStringList('viewed_ids', viewedIds);
  }
}
