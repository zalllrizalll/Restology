import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:restology/app/constant/custom_colors.dart';
import 'package:restology/app/routes/app_pages.dart';

import '../controllers/find_controller.dart';

class FindView extends GetView<FindController> {
  const FindView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Find Restaurant'), centerTitle: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller.findController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search Restaurant',
              ),
              onChanged: (value) {
                controller.searchRestaurants(value);
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: controller.searchRestaurants(
                controller.findController.text,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: CustomColors.primary),
                    ),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No result found',
                      style: TextStyle(color: CustomColors.primary),
                    ),
                  );
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
                                child: Image.network(
                                  'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(
                              restaurant.name ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: CustomColors.redColor,
                                ),
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
                                const Icon(
                                  Icons.star,
                                  color: CustomColors.secondary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  restaurant.rating?.toString() ?? '',
                                  style: const TextStyle(
                                    color: CustomColors.primary,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
