import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:restology/app/constant/custom_colors.dart';

class ShimmerWidgetView extends GetView {
  const ShimmerWidgetView({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(width: 80, height: 120, color: Colors.grey[300]),
        title: Container(
          height: 16,
          color: CustomColors.greyColor,
          margin: const EdgeInsets.only(bottom: 8),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(width: 20, height: 20, color: Colors.grey[300]),
            const SizedBox(width: 8),
            Container(height: 16, color: Colors.grey[300]),
          ],
        ),
        trailing: Container(width: 14, height: 14, color: Colors.grey[300]),
      ),
    );
  }
}
