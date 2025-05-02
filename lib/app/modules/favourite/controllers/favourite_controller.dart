import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:restology/app/data/models/restaurant_hive.dart';

class FavouriteController extends GetxController {
  final favBox = Hive.box<RestaurantHive>('favourite');

  RxBool isFavourite = false.obs;
  RxList<RestaurantHive> favouriteRestaurants = <RestaurantHive>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllFavourites();
  }

  @override
  void onClose() {
    super.onClose();
    favBox.close();
  }

  void addFavourite(RestaurantHive restaurant) {
    favBox.put(restaurant.id, restaurant);
    isFavourite.value = true;
    getAllFavourites();
  }

  void removeFavourite(String id) {
    favBox.delete(id);
    isFavourite.value = false;
    getAllFavourites();
  }

  bool checkFavourite(String id) {
    return favBox.containsKey(id);
  }

  List<RestaurantHive> getAllFavourites() {
    favouriteRestaurants.value = favBox.values.toList();
    return favouriteRestaurants;
  }
}
