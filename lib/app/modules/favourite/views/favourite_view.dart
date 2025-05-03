import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:restology/app/components/restaurant_item_widget.dart';
import 'package:restology/app/constant/custom_colors.dart';
import 'package:restology/app/utils/restaurant_mapper.dart';

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

                    return RestaurantItemWidget(
                      restaurant: restaurant.toRestaurantModel(),
                    );
                  },
                ),
      ),
    );
  }
}
