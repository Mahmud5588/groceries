import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';


class ProfileMenuItemWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onPressed;

  const ProfileMenuItemWidget({
    Key? key,
    required this.icon,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: appHeight(1.5),
          horizontal: appWidth(5),
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.border,
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.primaryDark,
              size: appWidth(6),
            ),
            SizedBox(width: appWidth(4)),
            Expanded(
              child: Text(
                text,
                style: AppTextStyle.body.copyWith(
                  fontSize: appWidth(4),
                  color: AppColors.textBlack,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppColors.textGrey,
              size: appWidth(6),
            ),
          ],
        ),
      ),
    );
  }
}