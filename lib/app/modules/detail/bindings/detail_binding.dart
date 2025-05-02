import 'package:get/get.dart';
import 'package:restology/app/modules/favourite/controllers/favourite_controller.dart';

import '../controllers/detail_controller.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailController>(() => DetailController());
    Get.lazyPut<FavouriteController>(() => FavouriteController());
  }
}
