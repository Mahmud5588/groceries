import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:groceries/features/authentication/data/model/user_credentials_model.dart';
import 'package:groceries/my_app.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'core/di/service_locator.dart';
import 'core/theme/theme_bloc.dart';

import 'package:easy_localization/easy_localization.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir= await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(UserCredentialsModelAdapter());
  await EasyLocalization.ensureInitialized();

  setUp();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('uz')],
      fallbackLocale: const Locale('en'),
      path: '',
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<ThemeBloc>()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}
