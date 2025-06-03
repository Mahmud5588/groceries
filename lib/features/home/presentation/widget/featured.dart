import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/features/home/domain/entities/product_entites.dart';

class FeaturedProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onPressed;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback onAddToCart;
  final int cartQuantity;
  final Function(Product) onIncrement;
  final Function(Product) onDecrement;

  const FeaturedProductCard({
    Key? key,
    required this.product,
    required this.onPressed,
    this.onFavoriteToggle,
    required this.onAddToCart,
    this.cartQuantity = 0,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                    child: product.image.isNotEmpty
                        ? Image.network(
                      product.image,
                      height: AppResponsive.height(18),
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/default_product.png',
                          height: AppResponsive.height(18),
                          width: double.infinity,
                          fit: BoxFit.contain,
                        );
                      },
                    )
                        : Image.asset(
                      'assets/images/default_product.png',
                      height: AppResponsive.height(18),
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                  if (product.isNew ?? false)
                    Positioned(
                      top: AppResponsive.height(1),
                      left: AppResponsive.width(2),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppResponsive.width(2),
                          vertical: AppResponsive.height(0.5),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'new_product'.tr(),
                          style: TextStyle(
                            fontSize: AppResponsive.width(3),
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    top: AppResponsive.height(0.5),
                    right: AppResponsive.width(1),
                    child: IconButton(
                      icon: Icon(
                        product.isFavorite ?? false ? Icons.favorite : Icons.favorite_border,
                        color: product.isFavorite ?? false ? Colors.red : theme.hintColor,
                        size: AppResponsive.width(6),
                      ),
                      onPressed: onFavoriteToggle,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AppResponsive.width(2)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.name,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontSize: AppResponsive.width(3.8),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppResponsive.height(0.3)),
                  Text(
                    product.unit,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.hintColor,
                      fontSize: AppResponsive.width(3.3),
                    ),
                  ),
                  SizedBox(height: AppResponsive.height(0.7)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.primaryColor,
                            fontSize: AppResponsive.width(4.0),
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: AppResponsive.width(1)),

                      if (cartQuantity == 0)
                        Container(
                          height: AppResponsive.width(7.5),
                          width: AppResponsive.width(7.5),
                          decoration: BoxDecoration(
                            color: theme.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.add, color: Colors.white, size: AppResponsive.width(4.5)),
                            onPressed: onAddToCart,
                          ),
                        )
                      else
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: AppResponsive.width(6),
                              height: AppResponsive.width(6),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                icon: Icon(Icons.remove_circle_outline, color: theme.primaryColor, size: AppResponsive.width(5.0)),
                                onPressed: () => onDecrement(product),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(0.5)),
                              child: Text(
                                cartQuantity.toString(),
                                style: theme.textTheme.titleMedium?.copyWith(fontSize: AppResponsive.width(3.8)),
                              ),
                            ),
                            SizedBox(
                              width: AppResponsive.width(6),
                              height: AppResponsive.width(6),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                icon: Icon(Icons.add_circle_outline, color: theme.primaryColor, size: AppResponsive.width(5.0)),
                                onPressed: () => onIncrement(product),
                              ),
                            ),
                          ],
                        ),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
