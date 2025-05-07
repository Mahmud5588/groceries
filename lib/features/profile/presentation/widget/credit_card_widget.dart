import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';


class CreditCardWidget extends StatelessWidget {
  final String cardType; // Masalan, "Master Card", "Visa Card"
  final String lastFourDigits; // Kartaning oxirgi 4 ta raqami
  final String expiryDate;
  final String cvv;
  final String? cardIconPath; // Karta turining ikonasi yo'li (Mastercard, Visa logosi)
  final Color? iconBackgroundColor; // Ikona orqasidagi doira rangi
  final bool isDefault; // Karta defaultmi yoki yo'q
  final VoidCallback? onEdit; // Tahrirlash tugmasiga bosilganda

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
    return Container(
      padding: EdgeInsets.all(appWidth(4)),
      margin: EdgeInsets.only(bottom: appHeight(2)), // Pastdan bo'shliq
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
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
          if (isDefault) // Agar default bo'lsa "DEFAULT" labelini ko'rsatish
            Padding(
              padding: EdgeInsets.only(bottom: appHeight(1)),
              child: Text(
                'DEFAULT',
                style: AppTextStyle.caption.copyWith(color: AppColors.primaryDark, fontWeight: FontWeight.bold),
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ikona doirasi
              if (cardIconPath != null) // Agar ikona yo'li berilgan bo'lsa
                Container(
                  width: appWidth(10),
                  height: appWidth(10),
                  decoration: BoxDecoration(
                    color: iconBackgroundColor ?? AppColors.primaryLight, // Berilgan yoki default rang
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      cardIconPath!, // Karta ikonasini ko'rsatish
                      width: appWidth(6),
                      height: appWidth(6),
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              else // Agar ikona yo'li berilmagan bo'lsa, default ikonka
                Container(
                  width: appWidth(10),
                  height: appWidth(10),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight, // Default rang
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.credit_card_outlined, // Default karta ikonasi
                    color: AppColors.primaryDark,
                    size: appWidth(5),
                  ),
                ),
              SizedBox(width: appWidth(3)), // Ikona va text orasidagi bo'shliq
              Expanded( // Matn joyni egallashi uchun
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cardType,
                      style: AppTextStyle.body.copyWith(fontWeight: FontWeight.bold, fontSize: appWidth(4)),
                    ),
                    SizedBox(height: appHeight(0.5)),
                    Text(
                      'XXXX XXXX XXXX $lastFourDigits', // Kartaning oxirgi raqamlari
                      style: AppTextStyle.body.copyWith(color: AppColors.textGrey, fontSize: appWidth(3.5)),
                    ),
                    SizedBox(height: appHeight(0.5)),
                    Row(
                      children: [
                        Text(
                          'Expiry : $expiryDate',
                          style: AppTextStyle.body.copyWith(color: AppColors.textGrey, fontSize: appWidth(3.5)),
                        ),
                        SizedBox(width: appWidth(3)),
                        Text(
                          'CVV : $cvv',
                          style: AppTextStyle.body.copyWith(color: AppColors.textGrey, fontSize: appWidth(3.5)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton( // Tahrirlash/O'q ikonasi
                icon: Icon(Icons.chevron_right, color: AppColors.textGrey, size: appWidth(6)),
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