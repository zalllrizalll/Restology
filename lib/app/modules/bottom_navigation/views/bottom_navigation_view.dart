import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:restology/app/modules/favourite/views/favourite_view.dart';
import 'package:restology/app/modules/find/views/find_view.dart';
import 'package:restology/app/modules/home/views/home_view.dart';
import 'package:restology/app/modules/settings/views/settings_view.dart';

import '../controllers/bottom_navigation_controller.dart';

class BottomNavigationView extends GetView<BottomNavigationController> {
  BottomNavigationView({super.key});

  final List<Widget> pages = [
    const HomeView(),
    const FindView(),
    const FavouriteView(),
    const SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () =>
            IndexedStack(index: controller.currentIndex.value, children: pages),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeIndex,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favourite',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
