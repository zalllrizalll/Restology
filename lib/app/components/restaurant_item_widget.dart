import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restology/app/constant/custom_colors.dart';
import 'package:restology/app/data/models/restaurant.dart';
import 'package:restology/app/routes/app_pages.dart';

class RestaurantItemWidget extends GetView {
  final Restaurant restaurant;
  const RestaurantItemWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DETAIL, arguments: restaurant.id);
      },
      child: Card(
        child: ListTile(
          leading: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 80,
              minHeight: 120,
              maxWidth: 80,
              maxHeight: 120,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            restaurant.name ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.location_on, color: CustomColors.redColor),
              const SizedBox(width: 4),
              Text(
                restaurant.city ?? '',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          trailing: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, color: CustomColors.secondary),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  restaurant.rating?.toString() ?? '',
                  style: const TextStyle(
                    color: CustomColors.primary,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
