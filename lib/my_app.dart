import 'package:flutter/material.dart';
import 'package:groceries/core/route/route_names.dart';

import 'core/const/utils/app_responsive.dart';
import 'core/route/route_generator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppResponsive.init(context);
    });
    return MaterialApp(
      initialRoute: RouteNames.splash,
      onGenerateRoute: AppRoute(context: context).onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
