import 'package:get/get.dart';
import 'package:restology/app/data/shared_prefs/theme_prefs.dart';

class SettingsController extends GetxController {
  RxBool isDarkMode = false.obs;

  late final ThemePrefs _themePrefs;

  @override
  void onInit() async {
    super.onInit();
    _themePrefs = await ThemePrefs.getInstance();
    isDarkMode.value = _themePrefs.getTheme();
  }

  void changeTheme() {
    isDarkMode.value = !isDarkMode.value;
    _themePrefs.saveTheme(isDarkMode.value);
  }
}
