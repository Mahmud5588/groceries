import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';


class ProfileMenuItemWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Widget? element;
  final VoidCallback? onPressed;

  const ProfileMenuItemWidget({
    super.key,
    required this.icon,
    required this.text,
    this.element,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    final theme = Theme.of(context);

    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: appHeight(1.5),
          horizontal: appWidth(5),
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: theme.scaffoldBackgroundColor,
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: theme.primaryColor,
              size: appWidth(6),
            ),
            SizedBox(width: appWidth(4)),
            Expanded(
              child: Text(
                text,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: appWidth(4),
                  color: theme.textTheme.bodyMedium?.color,
                ),
              ),
            ),
            if (element != null)
              element!
            else
              Icon(
                Icons.chevron_right,
                color: theme.hintColor,
                size: appWidth(6),
              ),
          ],
        ),
      ),
    );
  }
}
