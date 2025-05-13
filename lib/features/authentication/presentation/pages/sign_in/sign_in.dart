import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:groceries/core/const/strings/app_strings.dart';
import 'package:groceries/core/route/route_names.dart';
import 'package:groceries/features/authentication/presentation/widgets/button_widget.dart';
import 'package:groceries/features/authentication/presentation/widgets/my_textfield.dart' show MyTextField;
import '../../../../../core/const/strings/text_styles.dart';
import '../../../../../core/const/utils/app_responsive.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Assuming this function is defined in this file or imported
  InputDecoration buildInputDecoration({
    required String hintText,
    required IconData prefixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).hintColor, fontSize: appWidth(3.5)),
      prefixIcon: Icon(prefixIcon, color: Theme.of(context).hintColor, size: appWidth(5)),
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
      fillColor: Theme.of(context).cardColor, // Use cardColor or surface color for TextField background
      contentPadding: EdgeInsets.symmetric(vertical: appHeight(2), horizontal: appWidth(4)),
      counterText: "",
    );
  }


  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          SizedBox(
            height: AppResponsive.height(45),
            width: double.infinity,
            child: Image.asset('assets/images/sign_in.png', fit: BoxFit.cover),
          ),

          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).appBarTheme.foregroundColor),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 0,
            right: 0,
            child: Center(
              child: Text("welcome".tr(), style: AppTextStyle.titleWhite.copyWith(color: Theme.of(context).appBarTheme.foregroundColor)),
            ),
          ),

          Column(
            children: [
              SizedBox(height: AppResponsive.height(45)),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppResponsive.width(5),
                  ),
                  color: Theme.of(context).scaffoldBackgroundColor, // Use scaffold background color
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: AppResponsive.height(3)),
                        Text(
                          "welcomeBack".tr(),
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox(height: AppResponsive.height(1)),
                        Text(
                          "signInYourAccount".tr(),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).hintColor),
                        ),
                        SizedBox(height: AppResponsive.height(3)),

                        MyTextField(
                          controller: _emailController,
                          texts: "email".tr(),
                          icon: Icon(Icons.email, color: Theme.of(context).hintColor, size: appWidth(5)),
                          keyboardType: TextInputType.emailAddress,
                          decoration: buildInputDecoration(hintText:"email".tr(), prefixIcon: Icons.email),
                        ),
                        SizedBox(height: AppResponsive.height(2)),

                        MyTextField(
                          controller: _passwordController,
                          texts: "password".tr(),
                          icon: Icon(Icons.lock, color: Theme.of(context).hintColor, size: appWidth(5)),
                          obscureText: _obscurePassword,
                          keyboardType: TextInputType.text,
                          decoration: buildInputDecoration(hintText: "password".tr(), prefixIcon: Icons.lock).copyWith(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Theme.of(context).hintColor,
                                size: appWidth(5),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: AppResponsive.height(1.5)),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: (val) {
                                    setState(() => _rememberMe = val!);
                                  },
                                  activeColor: Theme.of(context).primaryColor,
                                ),
                                Text(
                                  "rememberMe".tr(),
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: appWidth(3.5)),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, RouteNames.forgotPasswordPage);
                              },
                              child: Text(
                                "forgotPassword".tr(),
                                style: AppTextStyle.body.copyWith(color: Theme.of(context).primaryColor, fontSize: appWidth(3.5)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppResponsive.height(2)),

                        SizedBox(
                          width: double.infinity,
                          height: AppResponsive.height(7),
                          child: ButtonWidget(
                            text: "login".tr(),
                            onPressed: () {
                              Navigator.pushNamed(context, RouteNames.bottomPage);
                              print('Login button tapped');
                            },
                          ),
                        ),
                        SizedBox(height: AppResponsive.height(3)),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "dontHaveAccount".tr(),
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: appWidth(3.5)),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, RouteNames.signUp);
                              },
                              child: Text(
                               "signUp".tr(),
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).textTheme.bodyMedium?.color, fontWeight: FontWeight.bold, fontSize: appWidth(3.5)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
