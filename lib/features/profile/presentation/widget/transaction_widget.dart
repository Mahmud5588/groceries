import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';

class TransactionItemWidget extends StatelessWidget {
  final String iconPath;
  final String type;
  final String dateTime;
  final String amount;
  final Color? iconBackgroundColor;

  const TransactionItemWidget({
    Key? key,
    required this.iconPath,
    required this.type,
    required this.dateTime,
    required this.amount,
    this.iconBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: appHeight(1.5)),
      margin: EdgeInsets.symmetric(horizontal: appWidth(5)),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.dividerColor,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: appWidth(10),
            height: appWidth(10),
            decoration: BoxDecoration(
              color: iconBackgroundColor ?? theme.colorScheme.surfaceContainerHigh,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                iconPath,
                width: appWidth(6),
                height: appWidth(6),
                fit: BoxFit.contain,
                color: theme.textTheme.bodyMedium?.color,
              ),
            ),
          ),
          SizedBox(width: appWidth(3)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: AppTextStyle.body.copyWith(fontWeight: FontWeight.bold, fontSize: appWidth(4), color: theme.textTheme.bodyMedium?.color),
                ),
                SizedBox(height: appHeight(0.5)),
                Text(
                  dateTime,
                  style: AppTextStyle.caption.copyWith(color: theme.hintColor, fontSize: appWidth(3.5)),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: AppTextStyle.body.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
              fontSize: appWidth(4),
            ),
          ),
        ],
      ),
    );
  }
}
