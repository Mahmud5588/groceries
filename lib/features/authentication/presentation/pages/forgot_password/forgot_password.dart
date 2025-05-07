import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/features/authentication/presentation/widgets/button_widget.dart';
import 'package:groceries/features/authentication/presentation/widgets/my_textfield.dart';

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
      backgroundColor: AppColors.backgroundPink,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPink,
        elevation: 0,
        title: Text(
          'Password Recovery',
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
            SizedBox(height: appHeight(3)),

            Text(
              'Forgot Password',
              style: AppTextStyle.heading.copyWith(fontSize: appWidth(6)),
            ),
            SizedBox(height: appHeight(1)),

            Text(
              'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy',
              style: AppTextStyle.body.copyWith(color: AppColors.textGrey, fontSize: appWidth(3.8)),
            ),
            SizedBox(height: appHeight(4)),

            MyTextField(
              controller: _emailController,
              texts: 'Email Address',
              icon: Icon(Icons.mail_outline, color: AppColors.textGrey, size: appWidth(5)),
              keyboardType: TextInputType.emailAddress,
              decoration: _buildInputDecoration(hintText: 'Email Address', prefixIcon: Icons.mail_outline),
            ),
            SizedBox(height: appHeight(4)),

            SizedBox(
              width: double.infinity,
              height: appHeight(7),
              child: ButtonWidget(
                text: 'Send link',
                onPressed: () {
                  print('Send link tapped. Email: ${_emailController.text}');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData prefixIcon,
    int? maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
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
}