import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:restology/app/constant/custom_colors.dart';
import 'package:restology/app/routes/app_pages.dart';

import '../controllers/favourite_controller.dart';

class FavouriteView extends GetView<FavouriteController> {
  const FavouriteView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favourites'), centerTitle: true),
      body: Obx(
        () =>
            controller.favouriteRestaurants.isEmpty
                ? const Center(
                  child: Text(
                    'No favourite restaurants',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.primary,
                    ),
                  ),
                )
                : ListView.builder(
                  itemCount: controller.favouriteRestaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = controller.favouriteRestaurants[index];

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
                              child: Hero(
                                tag: 'img-restaurant-${restaurant.id}',
                                child: Image.network(
                                  'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          title: Hero(
                            tag: 'name-restaurant-${restaurant.id}',
                            child: Text(
                              restaurant.name ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Hero(
                                tag: 'icon-location-${restaurant.id}',
                                child: const Icon(
                                  Icons.location_on,
                                  color: CustomColors.redColor,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Hero(
                                tag: 'location-restaurant-${restaurant.id}',
                                child: Text(
                                  restaurant.city ?? '',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                          trailing: Hero(
                            tag: 'rating-restaurant-${restaurant.id}',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: CustomColors.secondary,
                                ),
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
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
