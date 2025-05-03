import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:restology/app/constant/custom_theme.dart';
import 'package:restology/app/data/models/restaurant_hive.dart';
import 'package:restology/app/modules/settings/controllers/settings_controller.dart';
import 'package:workmanager/workmanager.dart';

import 'app/routes/app_pages.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'daily_reminder',
          'Daily Reminder',
          channelDescription: 'Channer for daily reminder',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
          playSound: true,
          enableVibration: true,
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Saatnya makan siang!',
      'Jangan lupa untuk makan siang hari ini.',
      platformChannelSpecifics,
    );

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(RestaurantHiveAdapter());

  await Hive.openBox<RestaurantHive>('favourite');

  final SettingsController settingsController = Get.put(SettingsController());

  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

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
