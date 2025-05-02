import 'package:hive_flutter/hive_flutter.dart';

part 'restaurant_hive.g.dart';

@HiveType(typeId: 0)
class RestaurantHive extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String? pictureId;

  @HiveField(4)
  String? city;

  @HiveField(5)
  num? rating;

  RestaurantHive({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
  });
}
