import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static late SharedPreferences prefs;

  /// Declare shared preferences
  static Future<void> cacheInitialization() async {
    prefs = await SharedPreferences.getInstance();
  }

  /// Set data
  static Future<bool> setData({required String key, required dynamic value}) async {
    if (value is int) {
      return await prefs.setInt(key, value);
    }

    if (value is String) {
      return await prefs.setString(key, value);
    }

    if (value is bool) {
      return await prefs.setBool(key, value);
    }

    if (value is double) {
      return await prefs.setDouble(key, value);
    }
    if(value is List<String>) {
      return await prefs.setStringList(key, value);
    }
    return false;
  }


  /// Get data
  static dynamic getData({required String key}) {
    return prefs.get(key);
  }

  /// Remove data
  static Future<bool> removeData({required String key}) async {
    return await prefs.remove(key);
  }

  /// Clear all data
  static Future<bool> clearAllData() async {
    return await prefs.clear();
  }
}
