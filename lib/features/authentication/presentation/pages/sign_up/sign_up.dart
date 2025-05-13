import 'package:easy_localization/easy_localization.dart';
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

  InputDecoration _buildInputDecoration({
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
      fillColor: Theme.of(context).cardColor,
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
            child: Image.asset(
              'assets/images/sign_in.png',
              fit: BoxFit.cover,
            ),
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
              child: Text(
               "welcome".tr(),
                style: AppTextStyle.titleWhite.copyWith(color: Theme.of(context).appBarTheme.foregroundColor),
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
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: AppResponsive.height(3)),
                        Text("welcomeBack".tr(), style: Theme.of(context).textTheme.headlineMedium),
                        SizedBox(height: AppResponsive.height(1)),
                        Text("createYourAccount".tr(), style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).hintColor)),
                        SizedBox(height: AppResponsive.height(3)),
                        MyTextField(
                          controller: _nameController,
                          texts:"name".tr(),
                          icon: Icon(Icons.person, color: Theme.of(context).hintColor, size: appWidth(5)),
                          keyboardType: TextInputType.name,
                          decoration: _buildInputDecoration(hintText: "name".tr(), prefixIcon: Icons.person),
                        ),
                        SizedBox(height: AppResponsive.height(2)),
                        MyTextField(
                          controller: _phoneController,
                          texts: "phone".tr(),
                          icon: Icon(Icons.phone, color: Theme.of(context).hintColor, size: appWidth(5)),
                          keyboardType: TextInputType.phone,
                          decoration: _buildInputDecoration(hintText: "phone".tr(), prefixIcon: Icons.phone),
                        ),
                        SizedBox(height: AppResponsive.height(2)),
                        MyTextField(
                          controller: _emailController,
                          texts: "email".tr(),
                          icon: Icon(Icons.email, color: Theme.of(context).hintColor, size: appWidth(5)),
                          keyboardType: TextInputType.emailAddress,
                          decoration: _buildInputDecoration(hintText: "email".tr(), prefixIcon: Icons.email),
                        ),
                        SizedBox(height: AppResponsive.height(2)),
                        MyTextField(
                          controller: _passwordController,
                          texts: "password".tr(),
                          icon: Icon(Icons.lock, color: Theme.of(context).hintColor, size: appWidth(5)),
                          obscureText: _obscurePassword,
                          keyboardType: TextInputType.text,
                          decoration: _buildInputDecoration(hintText: "password".tr(), prefixIcon: Icons.lock).copyWith(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_off : Icons.visibility,
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
                        SizedBox(height: AppResponsive.height(3)),
                        SizedBox(
                            width: double.infinity,
                            height: AppResponsive.height(7),
                            child: ButtonWidget(text:"signUp".tr(), onPressed: () {
                              Navigator.pushNamed(context, RouteNames.signIn);
                            })),
                        SizedBox(height: AppResponsive.height(3)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "alreadyHaveAccount".tr(),
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: appWidth(3.5)),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "signIn".tr(),
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
