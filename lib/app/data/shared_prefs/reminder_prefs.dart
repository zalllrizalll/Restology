import 'package:shared_preferences/shared_preferences.dart';

class ReminderPrefs {
  late final SharedPreferences _prefs;
  static const String dailyReminder = 'DAILY_REMINDER';

  ReminderPrefs._(this._prefs);

  static Future<ReminderPrefs> getInstance() async {
    final prefs = await SharedPreferences.getInstance();
    return ReminderPrefs._(prefs);
  }

  Future<void> saveReminder(bool isActive) async {
    try {
      await _prefs.setBool(dailyReminder, isActive);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  bool getReminder() {
    try {
      return _prefs.getBool(dailyReminder) ?? false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
