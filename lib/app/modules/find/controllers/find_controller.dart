import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:restology/app/data/models/restaurant.dart';
import 'package:restology/app/data/providers/search_restaurant_response_provider.dart';

class FindController extends GetxController {
  final SearchRestaurantResponseProvider _searchRestaurantResponseProvider =
      SearchRestaurantResponseProvider();

  final TextEditingController findController = TextEditingController();

  Future<List<Restaurant>> searchRestaurants(String query) async {
    try {
      final response = await _searchRestaurantResponseProvider
          .getSearchRestaurant(query);

      return response?.restaurants ?? [];
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
