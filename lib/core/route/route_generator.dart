import 'package:flutter/material.dart';
import 'package:groceries/bottom_navbar.dart';
import 'package:groceries/core/route/route_names.dart';
import 'package:groceries/features/authentication/presentation/pages/forgot_password/forgot_password.dart';
import 'package:groceries/features/authentication/presentation/pages/forgot_password/verify_number_page.dart';
import 'package:groceries/features/authentication/presentation/pages/sign_in/sign_in.dart';
import 'package:groceries/features/authentication/presentation/pages/sign_up/sign_up.dart';
import 'package:groceries/features/authentication/presentation/pages/splash_page/splash_page.dart';
import 'package:groceries/features/cart/presentation/pages/shopping_cart_page.dart';
import 'package:groceries/features/home/presentation/pages/category_page.dart';
import 'package:groceries/features/home/presentation/pages/favorites.dart';
import 'package:groceries/features/home/presentation/pages/filter.dart';
import 'package:groceries/features/home/presentation/pages/home.dart';
import 'package:groceries/features/home/presentation/pages/product_page.dart';
import 'package:groceries/features/profile/presentation/pages/about_me_page.dart';

import 'package:groceries/features/profile/presentation/pages/add_creditcard.dart';
import 'package:groceries/features/profile/presentation/pages/address_page.dart';
import 'package:groceries/features/profile/presentation/pages/language_page.dart';
import 'package:groceries/features/profile/presentation/pages/my_card_page.dart';
import 'package:groceries/features/profile/presentation/pages/notifications_page.dart';
import 'package:groceries/features/profile/presentation/pages/profile_page.dart';
import 'package:groceries/features/profile/presentation/pages/transaction_page.dart';

class AppRoute {
  BuildContext context;

  AppRoute({required this.context});

  Route onGenerateRoute(RouteSettings routeSetting) {
    switch (routeSetting.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (context) => SplashPage());
      case RouteNames.signIn:
        return MaterialPageRoute(builder: (context) => LoginPage());
      case RouteNames.signUp:
        return MaterialPageRoute(builder: (context) => SignUpPage());
      case RouteNames.homePage:
        return MaterialPageRoute(builder: (context) => HomePage());
      case RouteNames.productsPage:
        return MaterialPageRoute(builder: (context) => ProductPage( ));
      case RouteNames.categoryPage:
        return MaterialPageRoute(builder: (context) => CategoriesPage());
      case RouteNames.bottomPage:
        return MaterialPageRoute(builder: (context) => MyBottomNavbarWidget());
      case RouteNames.profilePage:
        return MaterialPageRoute(builder: (context) => ProfilePage());
      case RouteNames.addressPage:
        return MaterialPageRoute(builder: (context) => AddressPage());
      case RouteNames.notificationPage:
        return MaterialPageRoute(builder: (context) => NotificationsPage());
      case RouteNames.myCardPage:
        return MaterialPageRoute(builder: (context) => MyCardsPage());
      case RouteNames.addCreditCardPage:
        return MaterialPageRoute(builder: (context) => AddCreditCardPage());
      case RouteNames.transactionPage:
        return MaterialPageRoute(builder: (context) => TransactionsPage());
      case RouteNames.forgotPasswordPage:
        return MaterialPageRoute(builder: (context) => ForgotPassword());
      case RouteNames.verifyNumberPage:
        return MaterialPageRoute(builder: (context) => VerifyNumberPage());
      case RouteNames.aboutMePage:
        return MaterialPageRoute(builder: (context) => AboutMePage());
      case RouteNames.shoppingCartPage:
        return MaterialPageRoute(builder: (context) => ShoppingCartPage());
      case RouteNames.filterPage:
        return MaterialPageRoute(builder: (context) => ApplyFiltersPage());
      case RouteNames.favoritesPage:
        return MaterialPageRoute(builder: (context) => FavoritesPage());
      case RouteNames.languagePage:
        return MaterialPageRoute(builder: (context) => Language());

      default:
        return MaterialPageRoute(builder: (context) => Placeholder());
    }
  }
}
