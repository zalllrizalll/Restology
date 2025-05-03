import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:restology/app/components/restaurant_item_widget.dart';
import 'package:restology/app/constant/custom_colors.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurants'), centerTitle: true),
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

                return RestaurantItemWidget(restaurant: restaurant);
              },
            );
          }
        },
      ),
    );
  }
}
