import 'package:get/get.dart';
import 'package:restology/app/modules/find/controllers/find_controller.dart';
import 'package:restology/app/modules/home/controllers/home_controller.dart';

import '../controllers/bottom_navigation_controller.dart';

class BottomNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavigationController>(() => BottomNavigationController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<FindController>(() => FindController());
  }
}
