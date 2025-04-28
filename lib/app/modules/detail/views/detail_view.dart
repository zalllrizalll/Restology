import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:restology/app/constant/custom_colors.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  final String id;
  const DetailView({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Restaurant'), centerTitle: true),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: controller.fetchDetailRestaurant(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: CustomColors.primary),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: CustomColors.primary),
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
              return Column(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      'https://restaurant-api.dicoding.dev/images/medium/${snapshot.data!.pictureId}',
                      fit: BoxFit.cover,
                    ),
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
                              child: Text(
                                snapshot.data!.name ?? '',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
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
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: CustomColors.redColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${snapshot.data!.address}, ${snapshot.data!.city}',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
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
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
