import 'package:shared_preferences/shared_preferences.dart';

class ThemePrefs {
  late final SharedPreferences _prefs;
  static const String myTheme = 'MY_THEME';

  ThemePrefs._(this._prefs);

  static Future<ThemePrefs> getInstance() async {
    final prefs = await SharedPreferences.getInstance();
    return ThemePrefs._(prefs);
  }

  Future<void> saveTheme(bool isDark) async {
    try {
      await _prefs.setBool(myTheme, isDark);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  bool getTheme() {
    try {
      return _prefs.getBool(myTheme) ?? false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
