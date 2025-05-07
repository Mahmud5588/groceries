import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';


class AddressCardWidget extends StatelessWidget {
  final String name;
  final String address;
  final String phoneNumber;
  final bool isDefault;
  final VoidCallback? onEdit;

  const AddressCardWidget({
    Key? key,
    required this.name,
    required this.address,
    required this.phoneNumber,
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
              Container(
                width: appWidth(10),
                height: appWidth(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight, // Yengil yashil fon
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.location_on_outlined, // Manzil ikonasi
                  color: AppColors.primaryDark, // Ikonka rangi
                  size: appWidth(5),
                ),
              ),
              SizedBox(width: appWidth(3)), // Ikona va text orasidagi bo'shliq
              Expanded( // Matn joyni egallashi uchun
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTextStyle.body.copyWith(fontWeight: FontWeight.bold, fontSize: appWidth(4)),
                    ),
                    SizedBox(height: appHeight(0.5)),
                    Text(
                      address,
                      style: AppTextStyle.body.copyWith(color: AppColors.textGrey, fontSize: appWidth(3.5)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: appHeight(0.5)),
                    Text(
                      phoneNumber,
                      style: AppTextStyle.body.copyWith(color: AppColors.textGrey, fontSize: appWidth(3.5)),
                    ),
                  ],
                ),
              ),
              IconButton( // Tahrirlash/O'q ikonasi
                icon: Icon(Icons.chevron_right, color: AppColors.textGrey, size: appWidth(6)),
                onPressed: onEdit,
                padding: EdgeInsets.zero, // Default paddingni olib tashlash
                constraints: const BoxConstraints(), // Minimum o'lchamni olib tashlash
              ),
            ],
          ),
        ],
      ),
    );
  }
}