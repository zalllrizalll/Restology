import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:restology/app/constant/custom_theme.dart';
import 'package:restology/app/data/models/restaurant_hive.dart';
import 'package:restology/app/modules/settings/controllers/settings_controller.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(RestaurantHiveAdapter());

  await Hive.openBox<RestaurantHive>('favourite');

  final SettingsController settingsController = Get.put(SettingsController());

  runApp(
    Obx(
      () => GetMaterialApp(
        title: "Restology",
        debugShowCheckedModeBanner: false,
        theme:
            settingsController.isDarkMode.value
                ? CustomTheme.darkTheme
                : CustomTheme.lightTheme,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    ),
  );
}
