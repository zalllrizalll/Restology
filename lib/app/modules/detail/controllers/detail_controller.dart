import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restology/app/data/models/customer_reviews_model.dart';
import 'package:restology/app/data/models/restaurant.dart';
import 'package:restology/app/data/providers/customer_reviews_provider.dart';
import 'package:restology/app/data/providers/detail_restaurant_response_provider.dart';

class DetailController extends GetxController {
  final DetailRestaurantResponseProvider _detailRestaurantResponseProvider =
      DetailRestaurantResponseProvider();

  final CustomerReviewsProvider _customerReviewsProvider =
      CustomerReviewsProvider();

  final ValueNotifier<bool> isExpanded = ValueNotifier<bool>(false);

  RxList<CustomerReviews> reviews = <CustomerReviews>[].obs;

  final TextEditingController nameC = TextEditingController();
  final TextEditingController reviewC = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchCustomerReviews(Get.arguments);
  }

  Future<Restaurant?> fetchDetailRestaurant(String id) async {
    try {
      final response = await _detailRestaurantResponseProvider
          .getDetailRestaurant(id);
      return response?.restaurant;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> fetchCustomerReviews(String id) async {
    try {
      final response = await _detailRestaurantResponseProvider
          .getDetailRestaurant(id);
      reviews.value = response?.restaurant?.customerReviews ?? [];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addCustomerReview(String id) async {
    try {
      await _customerReviewsProvider.addCustomerReview(
        id,
        nameC.text,
        reviewC.text,
      );

      fetchCustomerReviews(id);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
