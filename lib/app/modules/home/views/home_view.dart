import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:restology/app/constant/custom_colors.dart';
import 'package:restology/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Restaurant'), centerTitle: true),
      body: FutureBuilder(
        future: controller.fetchRestaurants(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: CustomColors.primary),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.wifi_off,
                    color: CustomColors.primary,
                    size: 50,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Something went wrong',
                    style: TextStyle(color: CustomColors.primary, fontSize: 16),
                  ),
                ],
              ),
            );
          } else if (snapshot.data!.isEmpty) {
            return const Center(child: Text('No restaurants found'));
          } else {
            final restaurants = snapshot.data;

            return ListView.builder(
              itemCount: restaurants!.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];

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
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
            );
          }
        },
      ),
    );
  }
}
