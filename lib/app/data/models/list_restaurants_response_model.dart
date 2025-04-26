import 'package:restology/app/data/models/restaurant.dart';

class ListRestaurantsResponse {
  bool? error;
  String? message;
  num? count;
  List<Restaurant>? restaurants;

  ListRestaurantsResponse({
    this.error,
    this.message,
    this.count,
    this.restaurants,
  });

  ListRestaurantsResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    count = json['count'] as num?;
    if (json['restaurants'] != null) {
      restaurants = <Restaurant>[];
      json['restaurants'].forEach((v) {
        restaurants?.add(Restaurant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['error'] = error;
    data['message'] = message;
    data['count'] = count;
    if (restaurants != null) {
      data['restaurants'] = restaurants?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
