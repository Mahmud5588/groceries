import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/core/theme/theme_bloc.dart';
import 'package:groceries/core/theme/theme_state.dart'; // ThemeState ni import qiling
import 'package:groceries/features/authentication/data/model/user_credentials_model.dart';
import 'package:groceries/features/authentication/presentation/bloc/login/login_bloc.dart';
import 'package:groceries/features/authentication/presentation/bloc/logout/logout_bloc.dart';
import 'package:groceries/features/authentication/presentation/bloc/register/register_bloc.dart';
import 'package:groceries/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:groceries/features/home/presentation/bloc/products/products_bloc.dart';
import 'package:groceries/my_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/di/service_locator.dart';
import 'features/authentication/presentation/bloc/user/user_bloc.dart';
import 'features/cart/presentation/bloc/event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserCredentialsModelAdapter());
  await EasyLocalization.ensureInitialized();

  try {
    await setUp();
  } catch (e) {
    print("Xatolik service_locator.setUp() da: $e");
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('uz')],
      fallbackLocale: const Locale('en'),
      path: 'assets/translations',
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<ThemeBloc>()),
          BlocProvider(create: (context) => sl<LoginBloc>()),
          BlocProvider(create: (context) => sl<RegisterBloc>()),
          BlocProvider(create: (context) => sl<LogoutBloc>()),
          BlocProvider(create: (context) => sl<ProductBloc>()),
          BlocProvider(create: (context) => sl<UserProfileBloc>()),
          BlocProvider(
              create: (context) => sl<CartBloc>()..add(GetCartEvent())),
        ],
        child:
        const AppWithTheme(),
      ),
    ),
  );
}

class AppWithTheme extends StatelessWidget {
  const AppWithTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {

        return MyApp(themeModeFromBloc: themeState.themeMode);
      },
    );
  }
}