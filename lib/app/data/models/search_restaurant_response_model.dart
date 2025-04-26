import 'package:restology/app/data/models/restaurant.dart';

class SearchRestaurantResponse {
  bool? error;
  num? founded;
  List<Restaurant>? restaurants;

  SearchRestaurantResponse({this.error, this.founded, this.restaurants});

  SearchRestaurantResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    founded = json['founded'] as num?;
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
    data['founded'] = founded;
    if (restaurants != null) {
      data['restaurants'] = restaurants?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
