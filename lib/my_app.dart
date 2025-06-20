import 'package:flutter/material.dart';
import 'package:groceries/core/route/route_names.dart';
import 'core/const/utils/app_responsive.dart';
import 'core/route/route_generator.dart';
import 'core/const/colors/app_colors.dart';
import 'core/const/strings/text_styles.dart';
import 'package:easy_localization/easy_localization.dart';

class MyApp extends StatelessWidget {
  final ThemeMode themeModeFromBloc;

  const MyApp({super.key, required this.themeModeFromBloc});

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);

    Color? checkboxFill(Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primaryDark;
      }
      return null;
    }

    Color? switchThumb(Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.backgroundWhite;
      }
      return null;
    }

    Color? switchTrackLight(Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primaryDark;
      }
      return AppColors.textGrey.withOpacity(0.3);
    }

    Color? switchTrackDark(Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primaryDarkVariant;
      }
      return AppColors.borderDark;
    }

    final lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      hintColor: AppColors.textGrey,
      scaffoldBackgroundColor: AppColors.backgroundPink,
      cardColor: AppColors.backgroundWhite,
      dividerColor: AppColors.border,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundPink,
        foregroundColor: AppColors.textBlack,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        headlineMedium: AppTextStyle.heading,
        bodyMedium: AppTextStyle.body,
        bodySmall: AppTextStyle.caption,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primaryDark,
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: Colors.white,
          textStyle: AppTextStyle.button,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(checkboxFill),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(switchThumb),
        trackColor: WidgetStateProperty.resolveWith(switchTrackLight),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: AppTextStyle.body.copyWith(color: AppColors.textGrey),
        prefixIconColor: AppColors.textGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: AppColors.backgroundWhite,
        contentPadding: EdgeInsets.symmetric(
          vertical: AppResponsive.height(2),
          horizontal: AppResponsive.width(4),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primaryDark,
        unselectedItemColor: AppColors.textBlack,
        backgroundColor: AppColors.backgroundWhite,
        selectedLabelStyle: AppTextStyle.button
            .copyWith(fontSize: AppResponsive.width(3.5)),
        unselectedLabelStyle:
        AppTextStyle.button.copyWith(fontSize: AppResponsive.width(3)),
        type: BottomNavigationBarType.fixed,
        elevation: 8.0,
      ),
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.primaryDark,
        surface: AppColors.backgroundWhite,
        background: AppColors.backgroundPink,
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textBlack,
        onBackground: AppColors.textBlack,
        onError: Colors.white,
        surfaceContainerHighest: AppColors.border,
        surfaceContainerHigh: AppColors.border,
      ),
    );

    final darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryDarkVariant,
      hintColor: AppColors.textLightGrey,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      cardColor: AppColors.surfaceDark,
      dividerColor: AppColors.borderDark,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: AppColors.textWhite,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        headlineMedium: AppTextStyle.heading,
        bodyMedium: AppTextStyle.body,
        bodySmall: AppTextStyle.caption,
      ).apply(
        bodyColor: AppColors.textWhite,
        displayColor: AppColors.textWhite,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primaryDarkVariant,
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDarkVariant,
          foregroundColor: AppColors.textWhite,
          textStyle: AppTextStyle.button,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryDarkVariant;
          }
          return null;
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(switchThumb),
        trackColor: WidgetStateProperty.resolveWith(switchTrackDark),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: AppTextStyle.body.copyWith(color: AppColors.textLightGrey),
        prefixIconColor: AppColors.textLightGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: AppColors.surfaceDark,
        contentPadding: EdgeInsets.symmetric(
          vertical: AppResponsive.height(2),
          horizontal: AppResponsive.width(4),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primaryDarkVariant,
        unselectedItemColor: AppColors.textLightGrey,
        backgroundColor: AppColors.surfaceDark,
        selectedLabelStyle: AppTextStyle.button
            .copyWith(fontSize: AppResponsive.width(3.5)),
        unselectedLabelStyle:
        AppTextStyle.button.copyWith(fontSize: AppResponsive.width(3)),
        type: BottomNavigationBarType.fixed,
        elevation: 8.0,
      ),
      colorScheme: ColorScheme.dark(
        primary: AppColors.primaryDarkVariant,
        secondary: AppColors.primaryDark,
        surface: AppColors.surfaceDark,
        background: AppColors.backgroundDark,
        error: Colors.redAccent,
        onPrimary: AppColors.textWhite,
        onSecondary: AppColors.textWhite,
        onSurface: AppColors.textWhite,
        onBackground: AppColors.textWhite,
        onError: AppColors.textWhite,
        surfaceContainerHighest: const Color(0xff212121),
        surfaceContainerHigh: const Color(0xff212121),
      ),
    );

    return MaterialApp(
      title: 'Groceries App',
      initialRoute: RouteNames.splash,
      onGenerateRoute: AppRoute(context: context).onGenerateRoute,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeModeFromBloc,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      // home: const MyBottomNavbarWidget(),
    );
  }
}