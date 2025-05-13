import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/features/card/presentation/pages/shopping_cart_page.dart';
import 'package:groceries/features/home/presentation/pages/favorites.dart';
import 'package:groceries/features/home/presentation/pages/home.dart';
// import 'package:groceries/core/const/strings/app_strings.dart'; // AppStrings endi kerak emas bo'lishi mumkin
import 'core/const/utils/app_responsive.dart';
import 'features/profile/presentation/pages/profile_page.dart';
// easy_localization_generator ishlatilgan bo'lsa, LocaleKeys ni import qiling
// import 'package:groceries/generated/locale_keys.g.dart';


class MyBottomNavbarWidget extends StatefulWidget {
  const MyBottomNavbarWidget({super.key});

  @override
  State<MyBottomNavbarWidget> createState() => _MyBottomNavbarWidgetState();
}

class _MyBottomNavbarWidgetState extends State<MyBottomNavbarWidget> {
  int currentPage = 0;
  List<Widget> pages = [
    const HomePage(),
    const FavoritesPage(),
    const ProfilePage(),
    const ShoppingCartPage(),
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
        unselectedLabelStyle: theme.bottomNavigationBarTheme.unselectedLabelStyle,
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
            iconData: Icons.home,
            index: 0,
            selectedIndex: currentPage,
          ),
          bottomNavigationBarItemWidget(
            label: "favorite".tr(),
            iconData: Icons.favorite_border,
            index: 1,
            selectedIndex: currentPage,
          ),
          bottomNavigationBarItemWidget(
            label: "accounts".tr(),
            iconData: Icons.account_circle_outlined,
            index: 2,
            selectedIndex: currentPage,
          ),
          bottomNavigationBarItemWidget(
            label: "carts".tr(),
            iconData: Icons.shopping_bag_outlined,
            index: 3,
            selectedIndex: currentPage,
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem bottomNavigationBarItemWidget({
    required String label,
    required IconData iconData,
    required int index,
    required int selectedIndex,
  }) {

    final bool isSelected = index == selectedIndex;
    final theme = Theme.of(context);

    return BottomNavigationBarItem(
      label: label,
      icon: isSelected
          ?
      Container(
        padding: EdgeInsets.all(appWidth(2)),
        decoration: BoxDecoration(
          color: theme.primaryColor,
          shape: BoxShape.circle,
        ),
        child: Transform.scale(
          scale: 1.2,
          child: Icon(
            iconData,
            color: theme.colorScheme.onPrimary, // Tema rangidan foydalanish
            size: appWidth(6),
          ),
        ),
      )
          :
      Icon(
        iconData,
        color: theme.bottomNavigationBarTheme.unselectedItemColor, // Tema rangidan foydalanish
        size: appWidth(6),
      ),
    );
  }
}
