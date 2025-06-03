import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/core/di/service_locator.dart';
import 'package:groceries/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:groceries/features/cart/presentation/bloc/cart_state.dart';
import 'package:groceries/features/cart/presentation/bloc/event.dart';
import 'package:groceries/features/home/presentation/pages/favorites.dart';
import 'package:groceries/features/home/presentation/pages/home.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/features/cart/presentation/pages/shopping_cart_page.dart';
import 'package:groceries/features/profile/presentation/pages/profile_page.dart';


class MyBottomNavbarWidget extends StatefulWidget {
  const MyBottomNavbarWidget({super.key});

  @override
  State<MyBottomNavbarWidget> createState() => _MyBottomNavbarWidgetState();
}

class _MyBottomNavbarWidgetState extends State<MyBottomNavbarWidget> {
  int currentPage = 0;
  final List<Widget> pages = [
    const HomePage(),
    const FavoritesPage(),
    const ProfilePage(),
    const ShoppingCartPageProvider(),
  ];

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: theme.bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor: theme.bottomNavigationBarTheme.unselectedItemColor,
        currentIndex: currentPage,
        selectedLabelStyle: theme.bottomNavigationBarTheme.selectedLabelStyle,
        unselectedLabelStyle: theme.bottomNavigationBarTheme
            .unselectedLabelStyle,
        type: theme.bottomNavigationBarTheme.type,
        elevation: theme.bottomNavigationBarTheme.elevation ?? 8.0,
        backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
        onTap: (int newIndex) {
          setState(() {
            currentPage = newIndex;
          });
        },
        items: [
          bottomNavigationBarItemWidget(
              label: "home".tr(),
              iconData: Icons.home_outlined,
              selectedIconData: Icons.home_filled,
              index: 0,
              selectedIndex: currentPage,
              context: context
          ),
          bottomNavigationBarItemWidget(
              label: "favorite".tr(),
              iconData: Icons.favorite_border,
              selectedIconData: Icons.favorite,
              index: 1,
              selectedIndex: currentPage,
              context: context
          ),
          bottomNavigationBarItemWidget(
              label: "accounts".tr(),
              iconData: Icons.account_circle_outlined,
              selectedIconData: Icons.account_circle,
              index: 2,
              selectedIndex: currentPage,
              context: context
          ),
          BottomNavigationBarItem(
            label: "carts".tr(),
            icon: BlocProvider.value(
              value: sl<CartBloc>()
                ..add(GetCartEvent()),
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, cartState) {
                  int itemCount = 0;
                  if (cartState is CartLoaded) {
                    itemCount = cartState.cart.items.fold(
                        0, (sum, item) => sum + item.quantity);
                  } else
                  if (cartState is CartLoading && cartState.cart != null) {
                    itemCount = cartState.cart!.items.fold(
                        0, (sum, item) => sum + item.quantity);
                  }

                  final bool isSelected = 3 == currentPage;
                  final IconData currentIconData = isSelected ? Icons
                      .shopping_bag : Icons.shopping_bag_outlined;

                  Widget iconWidget;
                  if (isSelected) {
                    iconWidget = Container(
                      padding: EdgeInsets.all(AppResponsive.width(2)),
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Transform.scale(
                        scale: 1.2,
                        child: Icon(
                          currentIconData,
                          color: theme.colorScheme.onPrimary,
                          size: AppResponsive.width(6),
                        ),
                      ),
                    );
                  } else {
                    iconWidget = Icon(
                      currentIconData,
                      color: theme.bottomNavigationBarTheme.unselectedItemColor,
                      size: AppResponsive.width(6),
                    );
                  }

                  if (itemCount > 0) {
                    return Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        iconWidget,
                        Positioned(
                          right: AppResponsive.width(isSelected ? -2 : -1.5),
                          top: AppResponsive.height(isSelected ? -1.0 : -0.8),
                          child: Container(
                            padding: const EdgeInsets.all(2.5),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: theme.bottomNavigationBarTheme
                                        .backgroundColor ?? Colors.white,
                                    width: 1.5)
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              '$itemCount',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return iconWidget;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem bottomNavigationBarItemWidget({
    required String label,
    required IconData iconData,
    required IconData selectedIconData,
    required int index,
    required int selectedIndex,
    required BuildContext context,
  }) {
    final bool isSelected = index == selectedIndex;
    final theme = Theme.of(context);
    final IconData currentIcon = isSelected ? selectedIconData : iconData;

    return BottomNavigationBarItem(
      label: label,
      icon: isSelected
          ? Container(
        padding: EdgeInsets.all(AppResponsive.width(2)),
        decoration: BoxDecoration(
          color: theme.primaryColor,
          shape: BoxShape.circle,
        ),
        child: Transform.scale(
          scale: 1.2,
          child: Icon(
            currentIcon,
            color: theme.colorScheme.onPrimary,
            size: AppResponsive.width(6),
          ),
        ),
      )
          : Icon(
        currentIcon,
        color: theme.bottomNavigationBarTheme.unselectedItemColor,
        size: AppResponsive.width(6),
      ),
    );
  }
}