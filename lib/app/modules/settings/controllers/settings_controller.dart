import 'package:get/get.dart';
import 'package:restology/app/constant/my_workmanager.dart';
import 'package:restology/app/data/shared_prefs/reminder_prefs.dart';
import 'package:restology/app/data/shared_prefs/theme_prefs.dart';
import 'package:workmanager/workmanager.dart';

class SettingsController extends GetxController {
  RxBool isDarkMode = false.obs;
  RxBool isReminderActive = false.obs;

  late final ThemePrefs _themePrefs;
  late final ReminderPrefs _reminderPrefs;

  @override
  void onInit() {
    super.onInit();

    loadThemeSetting();
    loadReminderSetting();
  }

  void loadThemeSetting() async {
    _themePrefs = await ThemePrefs.getInstance();
    isDarkMode.value = _themePrefs.getTheme();
  }

  void changeTheme() {
    isDarkMode.value = !isDarkMode.value;
    _themePrefs.saveTheme(isDarkMode.value);
  }

  void loadReminderSetting() async {
    _reminderPrefs = await ReminderPrefs.getInstance();
    isReminderActive.value = _reminderPrefs.getReminder();

    if (isReminderActive.value) {
      scheduleDailyReminder();
    }
  }

  void changeReminder() {
    isReminderActive.value = !isReminderActive.value;
    _reminderPrefs.saveReminder(isReminderActive.value);

    if (isReminderActive.value) {
      scheduleDailyReminder();
    } else {
      cancelDailyReminder();
    }
  }

  void scheduleDailyReminder() {
    Workmanager().registerPeriodicTask(
      MyWorkManager.periodic.uniqueName,
      MyWorkManager.periodic.taskName,
      frequency: const Duration(hours: 24),
      initialDelay: _calculateInitialDelay(),
      constraints: Constraints(networkType: NetworkType.connected),
    );
  }

  Duration _calculateInitialDelay() {
    final now = DateTime.now();
    final targetTime = DateTime(now.year, now.month, now.day, 11, 0);

    final initialDelay =
        now.isAfter(targetTime)
            ? targetTime.add(const Duration(days: 1)).difference(now)
            : targetTime.difference(now);

    return initialDelay;
  }

  void cancelDailyReminder() {
    Workmanager().cancelByUniqueName(MyWorkManager.periodic.uniqueName);
  }
}
