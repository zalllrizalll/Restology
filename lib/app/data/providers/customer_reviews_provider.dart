import 'package:get/get.dart';
import 'package:restology/app/constant/url_server.dart';

class CustomerReviewsProvider extends GetConnect {
  Future<void> addCustomerReview(String id, String name, String review) async {
    await post('${UrlServer.baseUrl}/review', {
      'id': id,
      'name': name,
      'review': review,
    }, contentType: 'application/json');
  }
}
