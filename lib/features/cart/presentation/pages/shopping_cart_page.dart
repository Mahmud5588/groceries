import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/core/di/service_locator.dart';
import 'package:groceries/core/route/route_names.dart';
import 'package:groceries/features/authentication/presentation/widgets/button_widget.dart';
import 'package:groceries/features/cart/domain/entites/cart_item_entities.dart';
import 'package:groceries/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:groceries/features/cart/presentation/bloc/cart_state.dart';
import 'package:groceries/features/cart/presentation/bloc/event.dart';
import 'package:groceries/features/cart/presentation/widgets/shopping_cart_item_widget.dart';

class ShoppingCartPageProvider extends StatelessWidget {
  const ShoppingCartPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CartBloc>()..add(GetCartEvent()),
      child: const ShoppingCartPage(),
    );
  }
}

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  void _incrementQuantity(CartItem item) {
    context.read<CartBloc>().add(UpdateCartItemEvent(itemId: item.id, quantity: item.quantity + 1));
  }

  void _decrementQuantity(CartItem item) {
    if (item.quantity > 1) {
      context.read<CartBloc>().add(UpdateCartItemEvent(itemId: item.id, quantity: item.quantity - 1));
    } else {
      _deleteItem(item.id);
    }
  }

  void _deleteItem(int itemId) {
    context.read<CartBloc>().add(RemoveCartItemEvent(itemId: itemId));
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
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartAuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message.tr())), // Bu tarjima qilinishi mumkin bo'lgan xabar
            );
            Navigator.of(context).pushNamedAndRemoveUntil(
              RouteNames.signIn,
                  (route) => false,
            );
          } else if (state is CartError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)), // Bu to'g'ridan-to'g'ri xatolik matni
            );
          }
        },
        builder: (context, state) {
          final CartLoading? loadingState = state is CartLoading ? state : null;
          final CartLoaded? loadedState = state is CartLoaded ? state : null;

          if (loadingState != null && loadingState.cart == null) {
            return const Center(child: CircularProgressIndicator());
          } else if (loadedState != null || (loadingState != null && loadingState.cart != null)) {
            final cart = loadedState?.cart ?? loadingState!.cart!;

            if (cart.items.isEmpty && loadedState != null) {
              return Center(child: Text('cart_is_empty'.tr()));
            }

            if (cart.items.isEmpty && loadingState != null && loadingState.processingItemId == null && loadingState.processingProductId == null) {
              return Center(child: Text('cart_is_empty'.tr()));
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: appWidth(5), vertical: appHeight(2)),
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      bool isProcessingThisItem = loadingState?.processingItemId == item.id || loadingState?.processingProductId == item.productId;
                      return Opacity(
                        opacity: isProcessingThisItem ? 0.5 : 1.0,
                        child: Stack(
                          children: [
                            ShoppingCartItemWidget(
                              imageUrl: item.product!.image,
                              pricePerUnit: '\$${item.price.toStringAsFixed(2)}',
                              quantity: item.quantity,
                              productName: item.product!.name,
                              unit: item.product!.unit,
                              onAdd: isProcessingThisItem ? null : () => _incrementQuantity(item),
                              onRemove: isProcessingThisItem ? null : () => _decrementQuantity(item),
                              onDelete: isProcessingThisItem ? null : () => _deleteItem(item.id),
                            ),
                            if (isProcessingThisItem)
                              const Positioned.fill(
                                child: Center(
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                if (cart.items.isNotEmpty || (loadingState != null && loadingState.cart != null && loadingState.cart!.items.isNotEmpty))
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
                        ]),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('subtotal'.tr(), style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor, fontSize: appWidth(4))),
                            Text('\$${cart.subtotal.toStringAsFixed(2)}', style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor, fontSize: appWidth(4))),
                          ],
                        ),
                        SizedBox(height: appHeight(1)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('shippingCharges'.tr(), style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor, fontSize: appWidth(4))),
                            Text('\$${cart.shippingCharges.toStringAsFixed(2)}', style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor, fontSize: appWidth(4))),
                          ],
                        ),
                        SizedBox(height: appHeight(1)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('total'.tr(), style: theme.textTheme.headlineMedium?.copyWith(fontSize: appWidth(5))),
                            Text('\$${cart.total.toStringAsFixed(2)}', style: theme.textTheme.headlineMedium?.copyWith(fontSize: appWidth(5))),
                          ],
                        ),
                        SizedBox(height: appHeight(3)),
                        SizedBox(
                          width: double.infinity,
                          height: appHeight(7),
                          child: ButtonWidget(
                            text: 'checkout'.tr(),
                            onPressed: (loadingState != null || cart.items.isEmpty) ? null : () {
                              print('Checkout tapped with cart ID: ${cart.id}');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                if (cart.items.isEmpty && loadedState != null)
                  Expanded(child: Center(child: Text('cart_is_empty'.tr()))),
              ],
            );
          } else if (state is CartError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message), // .tr() olib tashlandi
                  SizedBox(height: appHeight(2)),
                  ElevatedButton(
                    onPressed: () => context.read<CartBloc>().add(GetCartEvent()),
                    child: Text('retry'.tr()),
                  )
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
