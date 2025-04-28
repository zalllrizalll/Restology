import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:restology/app/data/models/restaurant.dart';
import 'package:restology/app/data/providers/search_restaurant_response_provider.dart';

class FindController extends GetxController {
  final SearchRestaurantResponseProvider _searchRestaurantResponseProvider =
      SearchRestaurantResponseProvider();

  final TextEditingController findController = TextEditingController();

  RxList<Restaurant> restaurants = <Restaurant>[].obs;
  RxBool isLoading = false.obs;
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();

    debounce(searchQuery, (_) {
      if (searchQuery.value.isNotEmpty) {
        searchRestaurants();
      } else {
        restaurants.clear();
      }
    }, time: const Duration(milliseconds: 500));
  }

  Future<void> searchRestaurants() async {
    try {
      isLoading.value = true;
      final response = await _searchRestaurantResponseProvider
          .getSearchRestaurant(findController.text);

      restaurants.value = response?.restaurants ?? [];
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
