import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';


class CreditCardWidget extends StatelessWidget {
  final String cardType;
  final String lastFourDigits;
  final String expiryDate;
  final String cvv;
  final String? cardIconPath;
  final Color? iconBackgroundColor;
  final bool isDefault;
  final VoidCallback? onEdit;

  const CreditCardWidget({
    Key? key,
    required this.cardType,
    required this.lastFourDigits,
    required this.expiryDate,
    required this.cvv,
    this.cardIconPath,
    this.iconBackgroundColor,
    this.isDefault = false,
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(appWidth(4)),
      margin: EdgeInsets.only(bottom: appHeight(2)),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDefault)
            Padding(
              padding: EdgeInsets.only(bottom: appHeight(1)),
              child: Text(
                'DEFAULT',
                style: AppTextStyle.caption.copyWith(color: theme.primaryColor, fontWeight: FontWeight.bold),
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (cardIconPath != null)
                Container(
                  width: appWidth(10),
                  height: appWidth(10),
                  decoration: BoxDecoration(
                    color: iconBackgroundColor ?? theme.colorScheme.surfaceContainerHigh,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      cardIconPath!,
                      width: appWidth(6),
                      height: appWidth(6),
                      fit: BoxFit.contain,
                      color: theme.textTheme.bodyMedium?.color, // Optional: tint icon
                    ),
                  ),
                )
              else
                Container(
                  width: appWidth(10),
                  height: appWidth(10),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHigh,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.credit_card_outlined,
                    color: theme.primaryColor,
                    size: appWidth(5),
                  ),
                ),
              SizedBox(width: appWidth(3)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cardType,
                      style: AppTextStyle.body.copyWith(fontWeight: FontWeight.bold, fontSize: appWidth(4), color: theme.textTheme.bodyMedium?.color),
                    ),
                    SizedBox(height: appHeight(0.5)),
                    Text(
                      'XXXX XXXX XXXX $lastFourDigits',
                      style: AppTextStyle.body.copyWith(color: theme.hintColor, fontSize: appWidth(3.5)),
                    ),
                    SizedBox(height: appHeight(0.5)),
                    Row(
                      children: [
                        Text(
                          'Expiry : $expiryDate',
                          style: AppTextStyle.body.copyWith(color: theme.hintColor, fontSize: appWidth(3.5)),
                        ),
                        SizedBox(width: appWidth(3)),
                        Text(
                          'CVV : $cvv',
                          style: AppTextStyle.body.copyWith(color: theme.hintColor, fontSize: appWidth(3.5)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.chevron_right, color: theme.hintColor, size: appWidth(6)),
                onPressed: onEdit,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
