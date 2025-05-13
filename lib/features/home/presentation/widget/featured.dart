import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';

class FeaturedProductCard extends StatefulWidget {
  final String image;
  final String name;
  final String price;
  final String unit;
  final bool isNew;
  final Function() onPressed;

  const FeaturedProductCard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.unit,
    this.isNew = false,
    required this.onPressed,
  });

  @override
  State<FeaturedProductCard> createState() => _FeaturedProductCardState();
}

class _FeaturedProductCardState extends State<FeaturedProductCard> {
  int quantity = 0;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: AppResponsive.width(40), // Adjust width for better layout
        margin: EdgeInsets.all(appWidth(2)), // Adjust margin
        padding: EdgeInsets.all(appWidth(3)), // Adjust padding
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.dividerColor),
          color: theme.cardColor,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.all(appWidth(2.5)), // Adjust padding
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.colorScheme.surfaceContainerHighest, // Theme color
                      ),
                      child: Image.asset(
                        widget.image,
                        width: appWidth(18), // Responsive size
                        height: appWidth(18), // Responsive size
                      ),
                    ),
                  ),
                  if (widget.isNew)
                    Positioned(
                      top: appHeight(0.5), // Adjust position
                      left: appWidth(0.5), // Adjust position
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: appWidth(2), vertical: appHeight(0.5)), // Responsive padding
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary, // Theme color
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "NEW",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSecondary, // Theme color
                            fontWeight: FontWeight.bold,
                            fontSize: appWidth(2.5), // Responsive font size
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    top: appHeight(0.5), // Adjust position
                    right: appWidth(0.5), // Adjust position
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        size: appWidth(5), // Responsive size
                        color: isFavorite ? theme.colorScheme.error : theme.hintColor, // Theme colors
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: appHeight(1)), // Responsive spacing
              Text(
                widget.price,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor, // Theme color
                  fontWeight: FontWeight.bold,
                  fontSize: appWidth(4), // Responsive font size
                ),
              ),
              SizedBox(height: appHeight(0.5)), // Responsive spacing
              Text(widget.name,
                  style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: appWidth(4))), // Responsive font size
              SizedBox(height: appHeight(0.5)), // Responsive spacing
              Text(widget.unit,
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor, fontSize: appWidth(3))), // Responsive font size
              SizedBox(height: appHeight(1.5)), // Responsive spacing
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: appHeight(1.5)), // Responsive padding
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: theme.dividerColor)), // Theme color
                ),
                child: quantity == 0
                    ? GestureDetector(
                  onTap: () => setState(() => quantity = 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_bag_outlined, color: theme.primaryColor, size: appWidth(5)), // Theme color, Responsive size
                      SizedBox(width: appWidth(1.5)), // Responsive spacing
                      Text("Add to cart", style: theme.textTheme.bodyMedium?.copyWith(color: theme.textTheme.bodyMedium?.color, fontSize: appWidth(3.5))), // Theme color, Responsive font size
                    ],
                  ),
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline, size: appWidth(6)), // Responsive size
                      color: theme.primaryColor, // Theme color
                      onPressed: () {
                        setState(() {
                          quantity = quantity > 1 ? quantity - 1 : 0;
                        });
                      },
                    ),
                    Text(
                      "$quantity",
                      style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold, fontSize: appWidth(4)), // Responsive font size
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline, size: appWidth(6)), // Responsive size
                      color: theme.primaryColor, // Theme color
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
