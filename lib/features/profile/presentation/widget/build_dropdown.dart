

import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';

Widget buildDropdownField({
  required String hintText,
  required IconData prefixIcon,
  required String? value,
  required List<DropdownMenuItem<String>> items,
  required ValueChanged<String?> onChanged,
}) {
  return DropdownButtonFormField<String>(
    value: value,
    items: items,
    onChanged: onChanged,
    style: AppTextStyle.body.copyWith(fontSize: appWidth(3.5), color: AppColors.textBlack),
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: AppTextStyle.body.copyWith(color: AppColors.textGrey, fontSize: appWidth(3.5)),
      prefixIcon: Icon(prefixIcon, color: AppColors.textGrey, size: appWidth(5)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: AppColors.backgroundWhite,
      contentPadding: EdgeInsets.symmetric(vertical: appHeight(2), horizontal: appWidth(4)),
    ),
    icon: Icon(Icons.keyboard_arrow_down, color: AppColors.textGrey, size: appWidth(5)),
  );
}
