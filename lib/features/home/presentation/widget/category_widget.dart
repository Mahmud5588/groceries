import 'package:flutter/material.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/core/const/strings/text_styles.dart';

class CategoryItemWidget extends StatelessWidget {
  final String iconPath;
  final String name;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const CategoryItemWidget({
    Key? key,
    required this.iconPath,
    required this.name,
    required this.backgroundColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
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
        padding: EdgeInsets.symmetric(vertical: appHeight(1.5), horizontal: appWidth(1.5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: appWidth(13),
              height: appWidth(13),
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(appWidth(2.5)),
              child: Center(
                child: iconPath.startsWith('http') || iconPath.startsWith('https')
                    ? Image.network(
                  iconPath,
                  width: appWidth(7),
                  height: appWidth(7),
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.category_outlined,
                    size: appWidth(6),
                    color: theme.iconTheme.color?.withOpacity(0.7),
                  ),
                )
                    : iconPath.isNotEmpty
                    ? Image.asset(
                  iconPath,
                  width: appWidth(7),
                  height: appWidth(7),
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.category_outlined,
                    size: appWidth(6),
                    color: theme.iconTheme.color?.withOpacity(0.7),
                  ),
                )
                    : Icon(
                  Icons.category_outlined,
                  size: appWidth(6),
                  color: theme.iconTheme.color?.withOpacity(0.7),
                ),
              ),
            ),
            SizedBox(height: appHeight(1)),
            Text(
              name,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: appWidth(3.2),
                fontWeight: FontWeight.w500,
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
