import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static void setSessionKey(String sessionKey) {
    _prefs.then((value) => value.setString("sessionKey", sessionKey));
  }

  static Future<String?> getSessionKey() async {
    SharedPreferences sharedPreferences = await _prefs;
    return sharedPreferences.getString("sessionKey");
  }
}