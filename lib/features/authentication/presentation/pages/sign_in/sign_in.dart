import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/core/route/route_names.dart';
import 'package:groceries/features/authentication/presentation/bloc/event.dart';
import 'package:groceries/features/authentication/presentation/bloc/login/login_bloc.dart';
import 'package:groceries/features/authentication/presentation/bloc/login/login_state.dart';
import 'package:groceries/features/authentication/presentation/widgets/button_widget.dart';
import 'package:groceries/features/authentication/presentation/widgets/my_textfield.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/features/authentication/presentation/widgets/build_input_decoration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController(text: "axmedovmaxmud839@gmail.com");
  final TextEditingController _passwordController = TextEditingController(text: "maxmud1234");
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return PopScope(
          canPop: false,
          child: Dialog(
            child: Padding(
              padding: EdgeInsets.all(AppResponsive.width(5)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  SizedBox(height: AppResponsive.height(2)),
                  Text("logging_in".tr()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _dismissDialog() {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            _showLoadingDialog();
          } else {
            _dismissDialog();
          }

          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text("login_successful".tr())),
              );
            Navigator.pushNamedAndRemoveUntil(
                context, RouteNames.bottomPage, (route) => false);
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.error.tr()),
                  backgroundColor: Colors.red,
                ),
              );
          }
        },
        child: Column(
          children: [
            SizedBox(
              height: AppResponsive.height(45),
              width: double.infinity,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/sign_in.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Positioned(
                    top: MediaQuery.of(context).padding.top +
                        AppResponsive.height(1),
                    left: AppResponsive.width(2),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: theme.appBarTheme.foregroundColor,
                        size: AppResponsive.width(6),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).padding.top +
                        AppResponsive.height(2),
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        "welcome".tr(),
                        style: AppTextStyle.titleWhite.copyWith(
                          color: theme.appBarTheme.foregroundColor,
                          fontSize: AppResponsive.width(6),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: AppResponsive.width(5),
                ),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppResponsive.width(8)),
                    topRight: Radius.circular(AppResponsive.width(8)),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppResponsive.height(3)),
                      Text(
                        "welcomeBack".tr(),
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontSize: AppResponsive.width(6),
                        ),
                      ),
                      SizedBox(height: AppResponsive.height(1)),
                      Text(
                        "signInYourAccount".tr(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: theme.hintColor,
                          fontSize: AppResponsive.width(3.8),
                        ),
                      ),
                      SizedBox(height: AppResponsive.height(3)),
                      MyTextField(
                        controller: _emailController,
                        texts: "email".tr(),
                        icon: Icon(
                          Icons.email,
                          color: theme.hintColor,
                          size: AppResponsive.width(5),
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
                          size: AppResponsive.width(5),
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
                              size: AppResponsive.width(5),
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
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: AppResponsive.width(5),
                                  height: AppResponsive.height(5),
                                  child: Checkbox(
                                    value: _rememberMe,
                                    onChanged: (val) {
                                      setState(() => _rememberMe = val!);
                                    },
                                    activeColor: theme.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    side: BorderSide(
                                        color: theme.hintColor, width: 1.5),
                                  ),
                                ),
                                SizedBox(width: AppResponsive.width(1)),
                                Flexible(
                                  child: Text(
                                    "rememberMe".tr(),
                                    style:
                                    theme.textTheme.bodyMedium?.copyWith(
                                      fontSize: AppResponsive.width(3.5),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                RouteNames.forgotPasswordPage,
                              );
                            },
                            child: Text(
                              "forgotPassword".tr(),
                              style: AppTextStyle.body.copyWith(
                                color: theme.primaryColor,
                                fontSize: AppResponsive.width(3.5),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppResponsive.height(2)),
                      SizedBox(
                        width: double.infinity,
                        height: AppResponsive.height(7),
                        child: BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            final isLoading = state is LoginLoading;
                            return ButtonWidget(
                              text: "login".tr(),
                              onPressed: isLoading
                                  ? null
                                  : () {
                                final email = _emailController.text.trim();
                                final password = _passwordController.text.trim();

                                if (email.isEmpty || password.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "please_fill_all_fields"
                                                  .tr())),
                                    );
                                  return;
                                }
                                context.read<LoginBloc>().add(
                                  LoginEvent(
                                    email: email,
                                    password: password,
                                    device_name: "my_device",
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(height: AppResponsive.height(3)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "dontHaveAccount".tr(),
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontSize: AppResponsive.width(3.5)),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                RouteNames.signUp,
                              );
                            },
                            child: Text(
                              "signUp".tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                color: theme.textTheme.bodyMedium?.color,
                                fontWeight: FontWeight.bold,
                                fontSize: AppResponsive.width(3.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppResponsive.height(3)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}