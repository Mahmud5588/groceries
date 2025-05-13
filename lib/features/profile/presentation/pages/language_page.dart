import 'package:flutter/material.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:easy_localization/easy_localization.dart'; // easy_localization importi
// Agar codegen ishlatilgan bo'lsa, LocaleKeys ni import qiling
// import 'package:groceries/generated/locale_keys.g.dart';

class Language extends StatelessWidget {
  const Language({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    final theme = Theme.of(context);


    final List<Locale> supportedLocales = context.supportedLocales;

    final Locale currentLocale = context.locale;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: theme.appBarTheme.elevation ?? 0,
        title: Text(
          'language'.tr(),
          style: theme.textTheme.headlineMedium?.copyWith(fontSize: appWidth(5), color: theme.appBarTheme.foregroundColor), // Tema text stilidan foydalanish
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.appBarTheme.foregroundColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: appHeight(2), horizontal: appWidth(5)),
        itemCount: supportedLocales.length,
        itemBuilder: (context, index) {
          final locale = supportedLocales[index];
          String languageName;
          switch (locale.languageCode) {
            case 'en':
              languageName = 'English';
              break;
            case 'uz':
              languageName = 'O\'zbek';
              break;
            default:
              languageName = locale.languageCode;
          }

          final bool isSelected = locale == currentLocale;

          return Card(
            color: isSelected ? theme.primaryColor.withOpacity(0.1) : theme.cardColor,
            elevation: 2.0,
            margin: EdgeInsets.only(bottom: appHeight(1.5)),
            child: ListTile(
              title: Text(
                languageName,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: appWidth(4),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? theme.primaryColor : theme.textTheme.bodyMedium?.color,
                ),
              ),
              trailing: isSelected
                  ? Icon(Icons.check_circle, color: theme.primaryColor)
                  : null,
              onTap: () {

                context.setLocale(locale);
              },
            ),
          );
        },
      ),
    );
  }
}
