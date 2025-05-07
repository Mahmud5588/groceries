import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/app_strings.dart';
import 'package:groceries/core/route/route_names.dart';
import 'package:groceries/features/authentication/presentation/widgets/button_widget.dart';
import 'package:groceries/features/authentication/presentation/widgets/my_textfield.dart';
import '../../../../../core/const/strings/text_styles.dart';
import '../../../../../core/const/utils/app_responsive.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
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
            child: Image.asset(
              'assets/images/sign_in.png',
              fit: BoxFit.cover,
            ),
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
              child: Text(
                AppStrings.welcome,
                style: AppTextStyle.titleWhite,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: AppResponsive.height(45)),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(5)),
                  color: AppColors.backgroundWhite,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: AppResponsive.height(3)),
                        SizedBox(height: AppResponsive.height(1)),
                        SizedBox(height: AppResponsive.height(3)),
                        MyTextField(
                          texts: AppStrings.name,
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(height: AppResponsive.height(2)),
                        MyTextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: AppResponsive.height(2)),
                        MyTextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: AppResponsive.height(2)),
                        MyTextField(
                          texts: AppStrings.password,
                          obscureText: _obscurePassword,
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                        SizedBox(height: AppResponsive.height(3)),
                        SizedBox(
                            width: double.infinity,
                            child: ButtonWidget(text: AppStrings.signUp, onPressed: () {
                              Navigator.pushNamed(context, RouteNames.signUpPage);
                            })),
                        SizedBox(height: AppResponsive.height(3)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {},
                                AppStrings.signIn,
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