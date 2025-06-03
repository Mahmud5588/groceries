import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/core/route/route_names.dart';
import 'package:groceries/features/authentication/presentation/bloc/event.dart';
import 'package:groceries/features/authentication/presentation/bloc/register/register_bloc.dart';
import 'package:groceries/features/authentication/presentation/bloc/register/register_state.dart';
import 'package:groceries/features/authentication/presentation/widgets/build_input_decoration.dart';
import 'package:groceries/features/authentication/presentation/widgets/button_widget.dart';
import 'package:groceries/features/authentication/presentation/widgets/my_textfield.dart';
import '../../../../../core/const/strings/text_styles.dart';
import '../../../../../core/const/utils/app_responsive.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: Dialog(
          child: Padding(
            padding: EdgeInsets.all(AppResponsive.width(5)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: AppResponsive.height(2)),
                Text("registering".tr()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _dismissDialog() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  void _showResultDialog(String title, String message, {bool isSuccess = true}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (isSuccess) {
                Navigator.pushNamedAndRemoveUntil(context, RouteNames.signIn, (route) => false);
              }
            },
            child: Text("ok".tr()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocConsumer<RegisterBloc, RegisterState>(
        builder: (context, state) {
          final bool isLoading = state is RegisterLoading;
          return Stack(
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
                  icon: Icon(
                    Icons.arrow_back,
                    color: theme.appBarTheme.foregroundColor,
                  ),
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
                    style: AppTextStyle.titleWhite.copyWith(
                      color: theme.appBarTheme.foregroundColor,
                    ),
                  ),
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
                      color: theme.scaffoldBackgroundColor,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: AppResponsive.height(3)),
                            Text(
                              "welcomeBack".tr(),
                              style: theme.textTheme.headlineMedium,
                            ),
                            SizedBox(height: AppResponsive.height(1)),
                            Text(
                              "createYourAccount".tr(),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.hintColor,
                              ),
                            ),
                            SizedBox(height: AppResponsive.height(3)),
                            Row(
                              children: [
                                Expanded(
                                  child: MyTextField(
                                    controller: _firstNameController,
                                    texts: "first_name".tr(),
                                    icon: Icon(
                                      Icons.person_outline,
                                      color: theme.hintColor,
                                      size: appWidth(5),
                                    ),
                                    keyboardType: TextInputType.name,
                                    decoration: buildInputDecoration(
                                      context,
                                      hintText: "first_name".tr(),
                                      prefixIcon: Icons.person_outline,
                                    ),
                                  ),
                                ),
                                SizedBox(width: appWidth(4)),
                                Expanded(
                                  child: MyTextField(
                                    controller: _lastNameController,
                                    texts: "last_name".tr(),
                                    icon: Icon(
                                      Icons.person_outline,
                                      color: theme.hintColor,
                                      size: appWidth(5),
                                    ),
                                    keyboardType: TextInputType.name,
                                    decoration: buildInputDecoration(
                                      context,
                                      hintText: "last_name".tr(),
                                      prefixIcon: Icons.person_outline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: AppResponsive.height(2)),
                            MyTextField(
                              controller: _phoneController,
                              texts: "phone".tr(),
                              icon: Icon(
                                Icons.phone,
                                color: theme.hintColor,
                                size: appWidth(5),
                              ),
                              keyboardType: TextInputType.phone,
                              decoration: buildInputDecoration(
                                context,
                                hintText: "phone".tr(),
                                prefixIcon: Icons.phone,
                              ),
                            ),
                            SizedBox(height: AppResponsive.height(2)),
                            MyTextField(
                              controller: _emailController,
                              texts: "email".tr(),
                              icon: Icon(
                                Icons.email,
                                color: theme.hintColor,
                                size: appWidth(5),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              decoration: buildInputDecoration(
                                context,
                                hintText: "email".tr(),
                                prefixIcon: Icons.email,
                              ),
                            ),
                            SizedBox(height: AppResponsive.height(2)),
                            MyTextField(
                              controller: _passwordController,
                              texts: "password".tr(),
                              icon: Icon(
                                Icons.lock,
                                color: theme.hintColor,
                                size: appWidth(5),
                              ),
                              obscureText: _obscurePassword,
                              keyboardType: TextInputType.text,
                              decoration: buildInputDecoration(
                                context,
                                hintText: "password".tr(),
                                prefixIcon: Icons.lock,
                              ).copyWith(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: theme.hintColor,
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
                              child: ButtonWidget(
                                text: "signUp".tr(),
                                onPressed: isLoading
                                    ? null
                                    : () {
                                  final firstName = _firstNameController.text.trim();
                                  final lastName = _lastNameController.text.trim();
                                  final phone = _phoneController.text.trim();
                                  final email = _emailController.text.trim();
                                  final password = _passwordController.text.trim();

                                  if (firstName.isEmpty ||
                                      lastName.isEmpty ||
                                      phone.isEmpty ||
                                      email.isEmpty ||
                                      password.isEmpty) {
                                    _showResultDialog(
                                      "error".tr(),
                                      "please_fill_all_fields".tr(),
                                      isSuccess: false,
                                    );
                                    return;
                                  }

                                  context.read<RegisterBloc>().add(
                                    RegisterEvent(
                                      first_name: firstName,
                                      email: email,
                                      password: password,
                                      last_name: lastName,
                                      password_confirmation: password,
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: AppResponsive.height(3)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "alreadyHaveAccount".tr(),
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontSize: appWidth(3.5),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.signIn,
                                    );
                                  },
                                  child: Text(
                                    "signIn".tr(),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      color: theme.textTheme.bodyMedium?.color,
                                      fontWeight: FontWeight.bold,
                                      fontSize: appWidth(3.5),
                                    ),
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
          );
        },
        listener: (context, state) {
          if (state is RegisterLoading) {
            _showLoadingDialog();
          } else if (state is RegisterSuccess) {
            _dismissDialog();
            _showResultDialog(
              "success".tr(),
              "registration_successful".tr(),
              isSuccess: true,
            );
          } else if (state is RegisterFailure) {
            _dismissDialog();
            _showResultDialog(
              "error".tr(),
              "registration_failed".tr() + ": ${state.error}",
              isSuccess: false,
            );
          }
        },
      ),
    );
  }
}
