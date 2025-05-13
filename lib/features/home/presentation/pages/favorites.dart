import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/features/card/presentation/widgets/shopping_cart_item_widget.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final List<Map<String, dynamic>> _favoriteItems = [
    {'imageUrl': 'assets/images/peach.png', 'pricePerUnit': '\$2.22', 'quantity': 4, 'productName': 'Fresh Broccoli', 'unit': '1.50 lbs'},
    {'imageUrl': 'assets/images/peach.png', 'pricePerUnit': '\$2.22', 'quantity': 5, 'productName': 'Black Grapes', 'unit': '5.0 lbs'},
    {'imageUrl': 'assets/images/peach.png', 'pricePerUnit': '\$2.22', 'quantity': 5, 'productName': 'Avacoda', 'unit': '1.50 lbs'},
    {'imageUrl': 'assets/images/peach.png', 'pricePerUnit': '\$2.22', 'quantity': 5, 'productName': 'Pineapple', 'unit': 'dozen'},
  ];

  void _incrementQuantity(int index) {
    setState(() {
      _favoriteItems[index]['quantity']++;
    });
  }

  void _decrementQuantity(int index) {
    if (_favoriteItems[index]['quantity'] > 1) {
      setState(() {
        _favoriteItems[index]['quantity']--;
      });
    }
  }

  void _deleteItem(int index) {
    setState(() {
      _favoriteItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        title: Text(
          'favorites'.tr(),
          style: theme.textTheme.headlineMedium?.copyWith(fontSize: appWidth(5), color: theme.appBarTheme.foregroundColor),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.appBarTheme.foregroundColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: appWidth(5), vertical: appHeight(2)),
        itemCount: _favoriteItems.length,
        itemBuilder: (context, index) {
          final item = _favoriteItems[index];
          return ShoppingCartItemWidget(
            imageUrl: item['imageUrl'],
            pricePerUnit: item['pricePerUnit'],
            quantity: item['quantity'],
            productName: item['productName'],
            unit: item['unit'],
            onAdd: () => _incrementQuantity(index),
            onRemove: () => _decrementQuantity(index),
            onDelete: () => _deleteItem(index),
          );
        },
      ),
    );
  }
}
