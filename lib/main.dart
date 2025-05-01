import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:restology/app/constant/custom_theme.dart';
import 'package:restology/app/modules/settings/controllers/settings_controller.dart';

import 'app/routes/app_pages.dart';

void main() {
  final SettingsController settingsController = Get.put(SettingsController());

  runApp(
    Obx(
      () => GetMaterialApp(
        title: "Restology",
        debugShowCheckedModeBanner: false,
        theme: settingsController.isDarkMode.value ? CustomTheme.darkTheme : CustomTheme.lightTheme,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    ),
  );
}
