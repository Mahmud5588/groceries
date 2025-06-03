import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/core/route/route_names.dart';
import 'package:groceries/features/cart/presentation/widgets/shopping_cart_item_widget.dart';
import 'package:groceries/features/home/domain/entities/product_entites.dart';
import 'package:groceries/features/home/presentation/bloc/event.dart';
import 'package:groceries/features/home/presentation/bloc/products/products_bloc.dart';
import 'package:groceries/features/home/presentation/bloc/products/products_state.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchFavoritesEvent());
  }

  void _toggleFavorite(int productId) {
    context.read<ProductBloc>().add(ToggleFavoriteEvent(productId));
  }

  void _incrementQuantity(int index, List<Product> items) {}

  void _decrementQuantity(int index, List<Product> items) {}

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
          style: theme.textTheme.headlineMedium
              ?.copyWith(fontSize: appWidth(5), color: theme.appBarTheme.foregroundColor),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.appBarTheme.foregroundColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is AuthenticationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            Navigator.of(context).pushNamedAndRemoveUntil(
              RouteNames.signIn,
                  (route) => false,
            );
          } else if (state is ProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoritesLoaded) {
            if (state.favorites.isEmpty) {
              return Center(
                child: Text(
                  'no_favorites_yet'.tr(),
                  style: theme.textTheme.bodyLarge,
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: appWidth(5), vertical: appHeight(2)),
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                final item = state.favorites[index];
                return ShoppingCartItemWidget(
                  imageUrl: item.image,
                  pricePerUnit: '\$${item.price.toStringAsFixed(2)}',
                  quantity: 1,
                  productName: item.name,
                  unit: item.unit,
                  onAdd: () => _incrementQuantity(index, state.favorites),
                  onRemove: () => _decrementQuantity(index, state.favorites),
                  onDelete: () => _toggleFavorite(item.id),
                );
              },
            );
          } else if (state is ProductError) {
            return Center(child: Text('failed_to_load_favorites'.tr()));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}