import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:restology/app/constant/custom_colors.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: ListTile(
            title: const Text(
              'Dark Mode',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Obx(
              () => Text(controller.isDarkMode.value ? 'Enable' : 'Disable'),
            ),
            trailing: Obx(
              () => Switch(
                value: controller.isDarkMode.value,
                onChanged: (value) {
                  controller.changeTheme();
                },
                activeColor: CustomColors.primary,
                inactiveTrackColor: CustomColors.greyColor2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
