import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  void setValue(String key, String val) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, val);
  }

  Future<String> getValue(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? role = pref.getString(key);
    return role.toString();
  }
}
