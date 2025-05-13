import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/features/authentication/presentation/widgets/button_widget.dart';
import 'package:groceries/features/card/presentation/widgets/shopping_cart_item_widget.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  final List<Map<String, dynamic>> _cartItems =  [
    {'imageUrl': 'assets/images/peach.png', 'pricePerUnit': '\$2.22', 'quantity': 4, 'productName': 'Fresh Broccoli', 'unit': '1.50 lbs'},
    {'imageUrl': 'assets/images/peach.png', 'pricePerUnit': '\$2.22', 'quantity': 5, 'productName': 'Black Grapes', 'unit': '5.0 lbs'},
    {'imageUrl': 'assets/images/peach.png', 'pricePerUnit': '\$2.22', 'quantity': 5, 'productName': 'Avacado', 'unit': '1.50 lbs'},
    {'imageUrl': 'assets/images/peach.png', 'pricePerUnit': '\$2.22', 'quantity': 5, 'productName': 'Pineapple', 'unit': 'dozen'},
  ];

  double _subtotal = 0.0;
  final double _shippingCharges = 1.6;
  double _total = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateTotals();
  }

  void _calculateTotals() {
    double sub = 0.0;
    for (var item in _cartItems) {
      double price = double.parse(item['pricePerUnit'].toString().replaceAll('\$', ''));
      sub += price * item['quantity'];
    }
    setState(() {
      _subtotal = sub;
      _total = _subtotal + _shippingCharges;
    });
  }

  void _incrementQuantity(int index) {
    setState(() {
      _cartItems[index]['quantity']++;
      _calculateTotals();
    });
  }

  void _decrementQuantity(int index) {
    if (_cartItems[index]['quantity'] > 1) {
      setState(() {
        _cartItems[index]['quantity']--;
        _calculateTotals();
      });
    }
  }

  void _deleteItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
      _calculateTotals();
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
          "shoppingCart".tr(),
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: appWidth(5), vertical: appHeight(2)),
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                final item = _cartItems[index];
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
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: appWidth(5), vertical: appHeight(2)),
            decoration: BoxDecoration(
                color: theme.cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, -2),
                  ),
                ]
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('subtotal'.tr(), style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor, fontSize: appWidth(4))),
                    Text('\$${_subtotal.toStringAsFixed(1)}', style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor, fontSize: appWidth(4))),
                  ],
                ),
                SizedBox(height: appHeight(1)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('shippingCharges'.tr(), style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor, fontSize: appWidth(4))),
                    Text('\$${_shippingCharges.toStringAsFixed(1)}', style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor, fontSize: appWidth(4))),
                  ],
                ),
                SizedBox(height: appHeight(1)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('total'.tr(), style: theme.textTheme.headlineMedium?.copyWith(fontSize: appWidth(5))),
                    Text('\$${_total.toStringAsFixed(1)}', style: theme.textTheme.headlineMedium?.copyWith(fontSize: appWidth(5))),
                  ],
                ),
                SizedBox(height: appHeight(3)),
                SizedBox(
                  width: double.infinity,
                  height: appHeight(7),
                  child: ButtonWidget(
                    text: 'checkout'.tr(),
                    onPressed: () {
                      print('Checkout tapped');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
