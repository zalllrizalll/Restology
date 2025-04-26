import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:restology/app/constant/custom_colors.dart';
import 'package:restology/app/modules/find/views/find_view.dart';
import 'package:restology/app/modules/home/views/home_view.dart';

import '../controllers/bottom_navigation_controller.dart';

class BottomNavigationView extends GetView<BottomNavigationController> {
  BottomNavigationView({super.key});

  final List<Widget> pages = [const HomeView(), const FindView()];

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
          backgroundColor: CustomColors.primary,
          selectedItemColor: CustomColors.whiteColor,
          unselectedItemColor: CustomColors.greyColor,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Find',
            ),
          ],
        ),
      ),
    );
  }
}
