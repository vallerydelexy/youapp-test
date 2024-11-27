import 'package:shared_preferences/shared_preferences.dart';


class Preferences {

  static Future<String> getLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('isLoggedIn') ?? '';
  }

  static Future<bool> setLogin(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('isLoggedIn', value);
  }
}
