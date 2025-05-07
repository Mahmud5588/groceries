import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';


class CreditCardPreviewWidget extends StatelessWidget {
  // Bu yerga kartada ko'rsatiladigan ma'lumotlar keladi
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
    return Container(
      width: double.infinity, // Kenglikni to'ldirish
      height: appHeight(25), // Responsiv balandlik
      padding: EdgeInsets.all(appWidth(6)), // Ichki bo'shliq
      decoration: BoxDecoration(
        gradient: LinearGradient( // Yashil gradient fon
          colors: [AppColors.primaryDark, AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16), // Yumaloq chetlar
      ),
      child: Stack( // Elementlarni bir-birining ustiga qo'yish uchun
        children: [
          // Karta raqami
          Positioned(
            top: appHeight(2), // Tepadan joylashuv
            left: 0,
            child: Text(
              cardNumber,
              style: AppTextStyle.titleWhite.copyWith(fontSize: appWidth(4.5)),
            ),
          ),

          // Card Holder qismi
          Positioned(
            bottom: appHeight(2), // Pastdan joylashuv
            left: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CARD HOLDER',
                  style: AppTextStyle.caption.copyWith(color: AppColors.backgroundWhite.withOpacity(0.8)),
                ),
                SizedBox(height: appHeight(0.5)),
                Text(
                  cardHolderName,
                  style: AppTextStyle.body.copyWith(color: AppColors.backgroundWhite),
                ),
              ],
            ),
          ),

          // EXPIRES qismi
          Positioned(
            bottom: appHeight(2), // Pastdan joylashuv
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'EXPIRES',
                  style: AppTextStyle.caption.copyWith(color: AppColors.backgroundWhite.withOpacity(0.8)),
                ),
                SizedBox(height: appHeight(0.5)),
                Text(
                  expiryDate,
                  style: AppTextStyle.body.copyWith(color: AppColors.backgroundWhite),
                ),
              ],
            ),
          ),

          // Yuqori o'ngdagi dekorativ elementlar (misol uchun, Image.asset yoki CustomPaint bilan chizish mumkin)
          Positioned(
            top: 0,
            right: 0,
            child: Opacity(
              opacity: 0.5, // Shaffoflik
              child: Image.asset(
                'assets/images/card_decoration.png', // Dekorativ rasm yo'li (siz qo'shishingiz kerak)
                width: appWidth(20),
                height: appHeight(10),
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Chap yuqoridagi karta logosi (Mastercard, Visa)
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/icons/mastercard_logo.png', // Karta logosi yo'li (siz qo'shishingiz kerak)
              width: appWidth(15),
              height: appHeight(8),
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}