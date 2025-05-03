import 'package:restology/app/data/models/restaurant.dart';
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

extension RestaurantHiveMapper on RestaurantHive {
  Restaurant toRestaurantModel() {
    return Restaurant(
      id: id ?? '',
      name: name ?? '',
      description: description ?? '',
      pictureId: pictureId ?? '',
      city: city ?? '',
      rating: rating ?? 0.0,
    );
  }
}
