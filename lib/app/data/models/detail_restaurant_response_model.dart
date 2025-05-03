import 'package:restology/app/data/models/restaurant.dart';

class DetailRestaurantResponse {
  bool? error;
  String? message;
  Restaurant? restaurant;

  DetailRestaurantResponse({this.error, this.message, this.restaurant});

  DetailRestaurantResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    restaurant =
        json['restaurant'] != null
            ? Restaurant?.fromJson(json['restaurant'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['error'] = error;
    data['message'] = message;
    if (restaurant != null) {
      data['restaurant'] = restaurant?.toJson();
    }
    return data;
  }
}

class Categories {
  String? name;

  Categories({this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class Menus {
  List<Categories>? foods;
  List<Categories>? drinks;

  Menus({this.foods, this.drinks});

  Menus.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      foods = <Categories>[];
      json['foods'].forEach((v) {
        foods?.add(Categories.fromJson(v));
      });
    }
    if (json['drinks'] != null) {
      drinks = <Categories>[];
      json['drinks'].forEach((v) {
        drinks?.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (foods != null) {
      data['foods'] = foods?.map((v) => v.toJson()).toList();
    }
    if (drinks != null) {
      data['drinks'] = drinks?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
