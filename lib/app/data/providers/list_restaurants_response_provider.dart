import 'package:get/get.dart';
import 'package:restology/app/constant/url_server.dart';

import '../models/list_restaurants_response_model.dart';

class ListRestaurantsResponseProvider extends GetConnect {
  Future<ListRestaurantsResponse?> getListRestaurants() async {
    final response = await get('${UrlServer.baseUrl}/list');
    return ListRestaurantsResponse.fromJson(response.body);
  }
}
