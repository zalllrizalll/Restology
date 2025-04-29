import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:restology/app/constant/custom_colors.dart';
import 'package:restology/app/modules/find/views/shimmer_widget_view.dart';
import 'package:restology/app/routes/app_pages.dart';
import 'package:shimmer/shimmer.dart';

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
              style: const TextStyle(color: CustomColors.primary),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: CustomColors.greyColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: CustomColors.primary),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: CustomColors.greyColor,
                ),
                hintText: 'Search Restaurant',
              ),
              onChanged: (value) {
                controller.searchQuery.value = value;
              },
              onSubmitted: (value) {
                controller.searchQuery.value = value;
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.searchQuery.value.isEmpty) {
                return const Center(
                  child: Text(
                    'Start typing to search...',
                    style: TextStyle(color: CustomColors.primary),
                  ),
                );
              } else if (controller.isLoading.isTrue) {
                return ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      period: const Duration(milliseconds: 1500),
                      child: ShimmerWidgetView(),
                    );
                  },
                );
              } else if (controller.restaurants.isEmpty) {
                return const Center(
                  child: Text(
                    'No restaurants found',
                    style: TextStyle(color: CustomColors.primary),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: controller.restaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = controller.restaurants[index];

                    return TweenAnimationBuilder(
                      tween: Tween<Offset>(
                        begin: const Offset(0, 0.3),
                        end: Offset.zero,
                      ),
                      duration: Duration(milliseconds: 400 + (index * 120)),
                      builder: (context, offset, child) {
                        return Transform.translate(
                          offset: Offset(0, offset.dy * 20),
                          child: Opacity(opacity: 1 - offset.dy, child: child),
                        );
                      },
                      child: GestureDetector(
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
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
