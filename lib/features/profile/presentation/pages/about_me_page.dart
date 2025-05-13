import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/features/authentication/presentation/widgets/button_widget.dart';
import 'package:groceries/features/authentication/presentation/widgets/my_textfield.dart';


class AboutMePage extends StatefulWidget {
  const AboutMePage({Key? key}) : super(key: key);

  @override
  _AboutMePageState createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  InputDecoration _buildInputDecoration(BuildContext context, {
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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        title: Text(
          'aboutMe'.tr(),
          style: theme.textTheme.headlineMedium?.copyWith(fontSize: appWidth(5), color: theme.appBarTheme.foregroundColor),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.appBarTheme.foregroundColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: appWidth(5), vertical: appHeight(2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'personalDetails'.tr(),
              style: theme.textTheme.headlineMedium?.copyWith(fontSize: appWidth(4.5)),
            ),
            SizedBox(height: appHeight(2)),

            MyTextField(
              controller: _nameController,
              texts: 'Russell Austin',
              icon: Icon(Icons.person_outline, color: theme.hintColor, size: appWidth(5)),
              keyboardType: TextInputType.name,
              decoration: _buildInputDecoration(context, hintText: 'Russell Austin', prefixIcon: Icons.person_outline),
            ),
            SizedBox(height: appHeight(1.5)),

            MyTextField(
              controller: _emailController,
              texts: 'russell.partner@gmail.com',
              icon: Icon(Icons.mail_outline, color: theme.hintColor, size: appWidth(5)),
              keyboardType: TextInputType.emailAddress,
              decoration: _buildInputDecoration(context, hintText: 'russell.partner@gmail.com', prefixIcon: Icons.mail_outline),
            ),
            SizedBox(height: appHeight(1.5)),

            MyTextField(
              controller: _phoneController,
              texts: '+1 202 555 0142',
              icon: Icon(Icons.phone_outlined, color: theme.hintColor, size: appWidth(5)),
              keyboardType: TextInputType.phone,
              decoration: _buildInputDecoration(context, hintText: '+1 202 555 0142', prefixIcon: Icons.phone_outlined),
            ),
            SizedBox(height: appHeight(4)),

            Text(
              'changePassword'.tr(),
              style: theme.textTheme.headlineMedium?.copyWith(fontSize: appWidth(4.5)),
            ),
            SizedBox(height: appHeight(2)),

            MyTextField(
              controller: _currentPasswordController,
              texts: 'currentPassword'.tr(),
              icon: Icon(Icons.lock_outline, color: theme.hintColor, size: appWidth(5)),
              obscureText: _obscureCurrentPassword,
              keyboardType: TextInputType.text,
              decoration: _buildInputDecoration(context, hintText: 'currentPassword'.tr(), prefixIcon: Icons.lock_outline).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureCurrentPassword ? Icons.visibility_off : Icons.visibility,
                    color: theme.hintColor,
                    size: appWidth(5),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureCurrentPassword = !_obscureCurrentPassword;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: appHeight(1.5)),

            MyTextField(
              controller: _newPasswordController,
              texts: 'newPassword'.tr(),
              icon: Icon(Icons.lock_outline, color: theme.hintColor, size: appWidth(5)),
              obscureText: _obscureNewPassword,
              keyboardType: TextInputType.text,
              decoration: _buildInputDecoration(context, hintText: 'newPassword'.tr(), prefixIcon: Icons.lock_outline).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureNewPassword ? Icons.visibility_off : Icons.visibility,
                    color: theme.hintColor,
                    size: appWidth(5),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureNewPassword = !_obscureNewPassword;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: appHeight(1.5)),

            MyTextField(
              controller: _confirmPasswordController,
              texts: 'confirmPassword'.tr(),
              icon: Icon(Icons.lock_outline, color: theme.hintColor, size: appWidth(5)),
              obscureText: _obscureConfirmPassword,
              keyboardType: TextInputType.text,
              decoration: _buildInputDecoration(context, hintText: 'confirmPassword'.tr(), prefixIcon: Icons.lock_outline).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                    color: theme.hintColor,
                    size: appWidth(5),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: appHeight(4)),

            SizedBox(
              width: double.infinity,
              height: appHeight(7),
              child: ButtonWidget(
                text: 'saveSettings'.tr(),
                onPressed: () {
                  print('Save settings tapped');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
