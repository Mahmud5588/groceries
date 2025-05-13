import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart' show AppColors;
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';


class CategoryItemWidget extends StatelessWidget {
  final String iconPath;
  final String name;
  final Color backgroundColor;

  const CategoryItemWidget({
    Key? key,
    required this.iconPath,
    required this.name,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        print('Category tapped: $name');
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: appHeight(2), horizontal: appWidth(2)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: appWidth(12),
              height: appWidth(12),
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(appWidth(2.5)),
              child: Center(
                child: Image.asset(
                  iconPath,
                  width: appWidth(6),
                  height: appWidth(6),
                ),
              ),
            ),
            SizedBox(height: appHeight(1)),
            Text(
              name,
              textAlign: TextAlign.center,
              style: AppTextStyle.body.copyWith(
                fontSize: appWidth(3),
                color: theme.textTheme.bodyMedium?.color,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
