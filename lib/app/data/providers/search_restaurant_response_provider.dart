import 'package:get/get.dart';
import 'package:restology/app/constant/url_server.dart';

import '../models/search_restaurant_response_model.dart';

class SearchRestaurantResponseProvider extends GetConnect {
  Future<SearchRestaurantResponse?> getSearchRestaurant(String query) async {
    final response = await get('${UrlServer.baseUrl}/search?q=$query');
    return SearchRestaurantResponse.fromJson(response.body);
  }
}
