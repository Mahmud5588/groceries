import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
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

  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData prefixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: AppTextStyle.body.copyWith(color: AppColors.textGrey, fontSize: appWidth(3.5)),
      prefixIcon: Icon(prefixIcon, color: AppColors.textGrey, size: appWidth(5)),
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
      fillColor: AppColors.backgroundWhite,
      contentPadding: EdgeInsets.symmetric(vertical: appHeight(2), horizontal: appWidth(4)),
      counterText: "",
    );
  }


  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundPink,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPink,
        elevation: 0,
        title: Text(
          'About me',
          style: AppTextStyle.heading.copyWith(fontSize: appWidth(5)),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textBlack),
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
              'Personal Details',
              style: AppTextStyle.heading.copyWith(fontSize: appWidth(4.5)),
            ),
            SizedBox(height: appHeight(2)),

            MyTextField(
              controller: _nameController,
              texts: 'Russell Austin',
              icon: Icon(Icons.person_outline, color: AppColors.textGrey, size: appWidth(5)),
              keyboardType: TextInputType.name,
              decoration: _buildInputDecoration(hintText: 'Russell Austin', prefixIcon: Icons.person_outline),
            ),
            SizedBox(height: appHeight(1.5)),

            MyTextField(
              controller: _emailController,
              texts: 'russell.partner@gmail.com',
              icon: Icon(Icons.mail_outline, color: AppColors.textGrey, size: appWidth(5)),
              keyboardType: TextInputType.emailAddress,
              decoration: _buildInputDecoration(hintText: 'russell.partner@gmail.com', prefixIcon: Icons.mail_outline),
            ),
            SizedBox(height: appHeight(1.5)),

            MyTextField(
              controller: _phoneController,
              texts: '+1 202 555 0142',
              icon: Icon(Icons.phone_outlined, color: AppColors.textGrey, size: appWidth(5)),
              keyboardType: TextInputType.phone,
              decoration: _buildInputDecoration(hintText: '+1 202 555 0142', prefixIcon: Icons.phone_outlined),
            ),
            SizedBox(height: appHeight(4)),

            Text(
              'Change Password',
              style: AppTextStyle.heading.copyWith(fontSize: appWidth(4.5)),
            ),
            SizedBox(height: appHeight(2)),

            MyTextField(
              controller: _currentPasswordController,
              texts: 'Current password',
              icon: Icon(Icons.lock_outline, color: AppColors.textGrey, size: appWidth(5)),
              obscureText: _obscureCurrentPassword,
              keyboardType: TextInputType.text,
              decoration: _buildInputDecoration(hintText: 'Current password', prefixIcon: Icons.lock_outline).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureCurrentPassword ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.textGrey,
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
              texts: 'New password',
              icon: Icon(Icons.lock_outline, color: AppColors.textGrey, size: appWidth(5)),
              obscureText: _obscureNewPassword,
              keyboardType: TextInputType.text,
              decoration: _buildInputDecoration(hintText: 'New password', prefixIcon: Icons.lock_outline).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureNewPassword ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.textGrey,
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
              texts: 'Confirm password',
              icon: Icon(Icons.lock_outline, color: AppColors.textGrey, size: appWidth(5)),
              obscureText: _obscureConfirmPassword,
              keyboardType: TextInputType.text,
              decoration: _buildInputDecoration(hintText: 'Confirm password', prefixIcon: Icons.lock_outline).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.textGrey,
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
                text: 'Save settings',
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