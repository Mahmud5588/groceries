import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/core/route/route_names.dart';
import 'package:groceries/features/authentication/presentation/widgets/button_widget.dart';
import 'package:groceries/features/authentication/presentation/widgets/my_textfield.dart';

import '../../widgets/build_input_decoration.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        title: Text(
          'passwordRecovery'.tr(),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: appWidth(5),
            color: Theme.of(context).appBarTheme.foregroundColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).appBarTheme.foregroundColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: appWidth(5),
          vertical: appHeight(2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: appHeight(3)),

            Text(
              "forgotPassword".tr(),
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontSize: appWidth(6)),
            ),
            SizedBox(height: appHeight(1)),

            Text(
              'lorem'.tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).hintColor,
                fontSize: appWidth(3.8),
              ),
            ),
            SizedBox(height: appHeight(4)),

            MyTextField(
              controller: _emailController,
              texts: 'email'.tr(),
              icon: Icon(
                Icons.mail_outline,
                color: Theme.of(context).hintColor,
                size: appWidth(5),
              ),
              keyboardType: TextInputType.emailAddress,
              decoration: buildInputDecoration(
                context,
                hintText: "email".trim(),
                prefixIcon: Icons.mail_outline,
              ),
            ),
            SizedBox(height: appHeight(4)),

            SizedBox(
              width: double.infinity,
              height: appHeight(7),
              child: ButtonWidget(
                text: 'sendLink'.tr(),
                onPressed: () {
                  print('Send link tapped. Email: ${_emailController.text}');
                  Navigator.pushNamed(context, RouteNames.verifyNumberPage);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
