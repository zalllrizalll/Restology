import 'package:get/get.dart';
import 'package:restology/app/data/models/detail_restaurant_response_model.dart';
import 'package:restology/app/data/providers/detail_restaurant_response_provider.dart';

class DetailController extends GetxController {
  final DetailRestaurantResponseProvider _detailRestaurantResponseProvider =
      DetailRestaurantResponseProvider();

  Future<Restaurant?> fetchDetailRestaurant(String id) async {
    try {
      final response = await _detailRestaurantResponseProvider
          .getDetailRestaurant(id);
      return response?.restaurant;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
