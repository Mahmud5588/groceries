import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';

class TransactionItemWidget extends StatelessWidget {
  final String iconPath; // Tranzaksiya turining ikonasi (Mastercard, Visa, Paypal logolari)
  final String type; // Tranzaksiya turi (Masalan, "Master Card", "Paypal")
  final String dateTime; // Tranzaksiya sanasi va vaqti (Masalan, "Dec 12 2021 at 10:00 pm")
  final String amount; // Tranzaksiya miqdori (Masalan, "$89", "$567")
  final Color? iconBackgroundColor; // Ikona orqasidagi doira rangi

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
    // AppResponsive ni bu widget ishlatilishidan oldin ishga tushirilganiga ishonch hosil qiling
    // AppResponsive.init(context); // Odatda buni MaterialApp dan yuqoriroq qilasiz

    return Container(
      padding: EdgeInsets.symmetric(vertical: appHeight(1.5)), // Vertikal bo'shliq
      margin: EdgeInsets.symmetric(horizontal: appWidth(5)), // Sahifa paddingiga moslash
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.border, // Pastki chegara chizig'i
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          // Ikona doirasi
          Container(
            width: appWidth(10),
            height: appWidth(10),
            decoration: BoxDecoration(
              color: iconBackgroundColor ?? AppColors.primaryLight, // Berilgan yoki default rang
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                iconPath, // Ikona rasmi
                width: appWidth(6),
                height: appWidth(6),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(width: appWidth(3)), // Ikona va text orasidagi bo'shliq
          Expanded( // Matn qismi qolgan joyni egallashi uchun
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: AppTextStyle.body.copyWith(fontWeight: FontWeight.bold, fontSize: appWidth(4)),
                ),
                SizedBox(height: appHeight(0.5)),
                Text(
                  dateTime,
                  style: AppTextStyle.caption.copyWith(color: AppColors.textGrey, fontSize: appWidth(3.5)),
                ),
              ],
            ),
          ),
          // Tranzaksiya miqdori
          Text(
            amount,
            style: AppTextStyle.body.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDark, // Yashil rang
              fontSize: appWidth(4),
            ),
          ),
        ],
      ),
    );
  }
}