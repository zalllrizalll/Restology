import 'package:get/get.dart';
import 'package:restology/app/data/models/restaurant.dart';
import 'package:restology/app/data/providers/list_restaurants_response_provider.dart';

class HomeController extends GetxController {
  final ListRestaurantsResponseProvider _listRestaurantsResponseProvider =
      ListRestaurantsResponseProvider();

  Future<List<Restaurant>> fetchRestaurants() async {
    try {
      final response =
          await _listRestaurantsResponseProvider.getListRestaurants();
      return response?.restaurants ?? [];
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
