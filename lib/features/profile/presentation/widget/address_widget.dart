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
    super.key,
    required this.name,
    required this.address,
    required this.phoneNumber,
    this.isDefault = false,
    this.onEdit,
  });

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
            color: Colors.black.withOpacity(0.05), // Keeping a slight shadow for definition
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
              Container(
                width: appWidth(10),
                height: appWidth(10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHigh,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.location_on_outlined,
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
                      name,
                      style: AppTextStyle.body.copyWith(fontWeight: FontWeight.bold, fontSize: appWidth(4), color: theme.textTheme.bodyMedium?.color),
                    ),
                    SizedBox(height: appHeight(0.5)),
                    Text(
                      address,
                      style: AppTextStyle.body.copyWith(color: theme.hintColor, fontSize: appWidth(3.5)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: appHeight(0.5)),
                    Text(
                      phoneNumber,
                      style: AppTextStyle.body.copyWith(color: theme.hintColor, fontSize: appWidth(3.5)),
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
