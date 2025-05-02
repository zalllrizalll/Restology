import 'package:restology/app/data/models/detail_restaurant_response_model.dart';
import 'package:restology/app/data/models/restaurant_hive.dart';

extension RestaurantMapper on Restaurant {
  RestaurantHive toHiveModel() {
    return RestaurantHive(
      id: id ?? '',
      name: name ?? '',
      description: description ?? '',
      pictureId: pictureId ?? '',
      city: city ?? '',
      rating: rating ?? 0.0,
    );
  }
}
