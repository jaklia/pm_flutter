import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsManager {
  static const _tokenKey = "ACCESS_TOKEN";

  static Future<bool> saveToken(String token) async {
    var prefs = await SharedPreferences.getInstance();
    var success = await prefs.setString(_tokenKey, token);
    return success;
  }

  static Future<String> getToken() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(_tokenKey);
    return token;
  }
}
