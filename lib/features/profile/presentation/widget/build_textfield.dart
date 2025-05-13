import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';

Widget buildTextField(BuildContext context, {
  required TextEditingController controller,
  required String hintText,
  required IconData prefixIcon,
  int? maxLines = 1,
  TextInputType keyboardType = TextInputType.text,
  int? maxLength,
}) {
  final theme = Theme.of(context);
  return TextField(
    controller: controller,
    keyboardType: keyboardType,
    maxLines: maxLines,
    maxLength: maxLength,
    style: AppTextStyle.body.copyWith(fontSize: appWidth(3.5), color: theme.textTheme.bodyMedium?.color),
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: AppTextStyle.body.copyWith(color: theme.hintColor, fontSize: appWidth(3.5)),
      prefixIcon: Icon(prefixIcon, color: theme.hintColor, size: appWidth(5)),
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
      fillColor: theme.cardColor,
      contentPadding: EdgeInsets.symmetric(vertical: appHeight(2), horizontal: appWidth(4)),
      counterText: maxLength != null ? "" : null,
    ),
  );
}
