import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:restology/app/constant/custom_colors.dart';
import 'package:restology/app/modules/detail/views/review_view.dart';
import 'package:restology/app/modules/favourite/controllers/favourite_controller.dart';
import 'package:restology/app/utils/restaurant_mapper.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  final String id;
  const DetailView({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    final FavouriteController favouriteController =
        Get.find<FavouriteController>();
    favouriteController.isFavourite.value = favouriteController.checkFavourite(
      id,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Restaurant'), centerTitle: true),
      body: FutureBuilder(
        future: controller.fetchDetailRestaurant(id),
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
          } else if (snapshot.data == null) {
            return const Center(
              child: Text(
                'No result found',
                style: TextStyle(color: CustomColors.primary),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Hero(
                          tag: 'img-restaurant-${snapshot.data!.id}',
                          child: Image.network(
                            'https://restaurant-api.dicoding.dev/images/medium/${snapshot.data!.pictureId}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 15,
                        right: 15,
                        child: CircleAvatar(
                          backgroundColor: CustomColors.greyColor2,
                          child: IconButton(
                            onPressed: () {
                              if (favouriteController.isFavourite.value) {
                                favouriteController.removeFavourite(id);
                              } else {
                                favouriteController.addFavourite(
                                  snapshot.data!.toHiveModel(),
                                );
                              }
                            },
                            icon: Obx(
                              () => Icon(
                                favouriteController.isFavourite.value
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: CustomColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Hero(
                                tag: 'name-restaurant-${snapshot.data!.id}',
                                child: Text(
                                  snapshot.data!.name ?? '',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Hero(
                              tag: 'rating-restaurant-${snapshot.data!.id}',
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: CustomColors.secondary,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    snapshot.data!.rating.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Hero(
                              tag: 'icon-location-${snapshot.data!.id}',
                              child: const Icon(
                                Icons.location_on,
                                color: CustomColors.redColor,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Hero(
                              tag: 'location-restaurant-${snapshot.data!.id}',
                              child: Text(
                                '${snapshot.data!.address}, ${snapshot.data!.city}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(color: CustomColors.greyColor, thickness: 1),
                        const SizedBox(height: 8),
                        ValueListenableBuilder<bool>(
                          valueListenable: controller.isExpanded,
                          builder: (context, expanded, _) {
                            final description =
                                snapshot.data!.description ?? '';

                            return RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: CustomColors.greyColor,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        expanded
                                            ? description
                                            : (description.length > 200
                                                ? description.substring(0, 200)
                                                : description),
                                  ),
                                  if (description.length > 200)
                                    TextSpan(
                                      text:
                                          expanded
                                              ? '...Show less'
                                              : '...Read more',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: CustomColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      recognizer:
                                          TapGestureRecognizer()
                                            ..onTap = () {
                                              controller.isExpanded.value =
                                                  !expanded;
                                            },
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Makanan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.menus!.foods!.length,
                            itemBuilder: (context, index) {
                              final food = snapshot.data!.menus!.foods![index];

                              return Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: CustomColors.primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    food.name ?? '',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Minuman',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.menus!.drinks!.length,
                            itemBuilder: (context, index) {
                              final drink =
                                  snapshot.data!.menus!.drinks![index];

                              return Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: CustomColors.primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    drink.name ?? '',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Review',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Obx(
                          () => ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.reviews.length,
                            itemBuilder: (context, index) {
                              final review = controller.reviews[index];

                              return Card(
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.person,
                                    color: CustomColors.primary,
                                  ),
                                  title: Text(
                                    review.name ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(review.review ?? ''),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Tambah Review'),
                actions: [
                  TextButton(
                    onPressed: () {
                      controller.nameC.clear();
                      controller.reviewC.clear();
                      Get.back();
                    },
                    child: const Text(
                      'Batal',
                      style: TextStyle(color: CustomColors.greyColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.addCustomerReview(id);
                      controller.nameC.clear();
                      controller.reviewC.clear();
                      Get.back();
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: CustomColors.primary),
                    ),
                  ),
                ],
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ReviewView(controller: controller.nameC, hintText: 'Nama'),
                    const SizedBox(height: 8),
                    ReviewView(
                      controller: controller.reviewC,
                      hintText: 'Deskripsi Review',
                    ),
                  ],
                ),
              );
            },
          );
        },
        shape: const CircleBorder(),
        backgroundColor: CustomColors.greyColor2,
        child: const Icon(Icons.edit, color: CustomColors.primary),
      ),
    );
  }
}
