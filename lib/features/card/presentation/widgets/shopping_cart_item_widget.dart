import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart' show AppColors;
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';


class ShoppingCartItemWidget extends StatelessWidget {
  final String imageUrl;
  final String pricePerUnit;
  final int quantity;
  final String productName;
  final String unit;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;
  final VoidCallback? onDelete;

  const ShoppingCartItemWidget({
    Key? key,
    required this.imageUrl,
    required this.pricePerUnit,
    required this.quantity,
    required this.productName,
    required this.unit,
    this.onAdd,
    this.onRemove,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    final theme = Theme.of(context);

    return Dismissible(
      key: Key(productName),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          if (onDelete != null) {
            onDelete!();
          }
        }
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: appWidth(5)),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: appWidth(7),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: appHeight(2), horizontal: appWidth(5)),
        margin: EdgeInsets.only(bottom: appHeight(1.5)),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: appWidth(18),
              height: appWidth(18),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: appWidth(4)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$pricePerUnit x $quantity',
                    style: AppTextStyle.body.copyWith(color: theme.primaryColor, fontWeight: FontWeight.bold, fontSize: appWidth(3.8)),
                  ),
                  SizedBox(height: appHeight(0.5)),
                  Text(
                    productName,
                    style: AppTextStyle.body.copyWith(fontWeight: FontWeight.bold, fontSize: appWidth(4), color: theme.textTheme.bodyMedium?.color),
                  ),
                  SizedBox(height: appHeight(0.5)),
                  Text(
                    unit,
                    style: AppTextStyle.body.copyWith(color: theme.hintColor, fontSize: appWidth(3.5)),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.add, color: theme.primaryColor, size: appWidth(6)),
                  onPressed: onAdd,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                SizedBox(height: appHeight(0.5)),
                Text(
                  quantity.toString(),
                  style: AppTextStyle.body.copyWith(fontWeight: FontWeight.bold, fontSize: appWidth(4), color: theme.textTheme.bodyMedium?.color),
                ),
                SizedBox(height: appHeight(0.5)),
                IconButton(
                  icon: Icon(Icons.remove, color: theme.hintColor, size: appWidth(6)),
                  onPressed: onRemove,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
