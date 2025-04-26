import 'package:get/get.dart';
import 'package:restology/app/constant/url_server.dart';

import '../models/detail_restaurant_response_model.dart';

class DetailRestaurantResponseProvider extends GetConnect {
  Future<DetailRestaurantResponse?> getDetailRestaurant(String id) async {
    final response = await get('${UrlServer.baseUrl}/detail/$id');
    return DetailRestaurantResponse.fromJson(response.body);
  }
}
