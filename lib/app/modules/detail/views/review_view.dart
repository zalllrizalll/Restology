import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:restology/app/constant/custom_colors.dart';

class ReviewView extends GetView {
  @override
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String hintText;
  const ReviewView({
    super.key,
    required this.controller,
    required this.hintText,
    required this.textInputAction,
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: CustomColors.greyColor),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: CustomColors.primary),
        ),
        hintText: hintText,
      ),
      maxLines: 1,
    );
  }
}
