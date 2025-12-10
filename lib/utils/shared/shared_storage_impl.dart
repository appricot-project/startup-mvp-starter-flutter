import 'package:shared_preferences/shared_preferences.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';

class SharedStorageImpl implements SharedStorage {
  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }
}
