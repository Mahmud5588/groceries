import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';


class CreditCardPreviewWidget extends StatelessWidget {
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;

  const CreditCardPreviewWidget({
    Key? key,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      height: appHeight(25),
      padding: EdgeInsets.all(appWidth(6)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.colorScheme.primary, theme.colorScheme.primaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            top: appHeight(2),
            left: 0,
            child: Text(
              cardNumber,
              style: AppTextStyle.titleWhite.copyWith(fontSize: appWidth(4.5), color: theme.colorScheme.onPrimary),
            ),
          ),

          Positioned(
            bottom: appHeight(2),
            left: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CARD HOLDER',
                  style: AppTextStyle.caption.copyWith(color: theme.colorScheme.onPrimary.withOpacity(0.8)),
                ),
                SizedBox(height: appHeight(0.5)),
                Text(
                  cardHolderName,
                  style: AppTextStyle.body.copyWith(color: theme.colorScheme.onPrimary),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: appHeight(2),
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'EXPIRES',
                  style: AppTextStyle.caption.copyWith(color: theme.colorScheme.onPrimary.withOpacity(0.8)),
                ),
                SizedBox(height: appHeight(0.5)),
                Text(
                  expiryDate,
                  style: AppTextStyle.body.copyWith(color: theme.colorScheme.onPrimary),
                ),
              ],
            ),
          ),

          Positioned(
            top: 0,
            right: 0,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                'assets/images/card_decoration.png',
                width: appWidth(20),
                height: appHeight(10),
                fit: BoxFit.contain,
                color: theme.colorScheme.onPrimary.withOpacity(0.5), // Optional: tint decoration based on theme
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/icons/mastercard_logo.png',
              width: appWidth(15),
              height: appHeight(8),
              fit: BoxFit.contain,
              color: theme.colorScheme.onPrimary, // Optional: tint logo based on theme
            ),
          ),
        ],
      ),
    );
  }
}
