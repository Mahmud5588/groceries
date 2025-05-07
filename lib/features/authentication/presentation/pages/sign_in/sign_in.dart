import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/app_strings.dart';
import 'package:groceries/core/route/route_names.dart';
import 'package:groceries/features/authentication/presentation/widgets/button_widget.dart';
import 'package:groceries/features/authentication/presentation/widgets/my_textfield.dart';
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

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    return Scaffold(
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
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 0,
            right: 0,
            child: Center(
              child: Text(AppStrings.welcome, style: AppTextStyle.titleWhite),
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
                  color: AppColors.backgroundWhite,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: AppResponsive.height(3)),
                        const Text(
                          AppStrings.welcomeBack,
                          style: AppTextStyle.heading,
                        ),
                        SizedBox(height: AppResponsive.height(1)),
                        const Text(
                          AppStrings.signInYourAccount,
                          style: AppTextStyle.caption,
                        ),
                        SizedBox(height: AppResponsive.height(3)),

                        MyTextField(
                          texts: AppStrings.email,
                          icon: const Icon(Icons.email),
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: AppResponsive.height(2)),

                        MyTextField(
                          texts: AppStrings.password,
                          icon: const Icon(Icons.lock),
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          element: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
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
                                  activeColor: AppColors.primary,
                                ),
                                const Text(AppStrings.rememberMe),
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                AppStrings.forgotPassword,
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppResponsive.height(2)),

                        SizedBox(
                          width: double.infinity,
                          height: AppResponsive.height(6),
                          child: ButtonWidget(
                            text: AppStrings.login,
                            onPressed: () {
                              Navigator.pushNamed(context, RouteNames.bottomPage);
                            },
                          ),
                        ),
                        SizedBox(height: AppResponsive.height(3)),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(AppStrings.dontHaveAccount),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, RouteNames.signUp);
                              },
                              child: const Text(
                                AppStrings.signUp,
                                style: TextStyle(color: Colors.black),
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
