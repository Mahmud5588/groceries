import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';

InputDecoration buildInputDecoration({
  required String hintText,
  required IconData prefixIcon,
  int? maxLines = 1,
  TextInputType keyboardType = TextInputType.text,
  int? maxLength,
}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: AppTextStyle.body.copyWith(color: AppColors.textGrey, fontSize: appWidth(3.5)),
    prefixIcon: Icon(prefixIcon, color: AppColors.textGrey, size: appWidth(5)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    filled: true,
    fillColor: AppColors.backgroundWhite,
    contentPadding: EdgeInsets.symmetric(vertical: appHeight(2), horizontal: appWidth(4)),
    counterText: "",
  );
}
