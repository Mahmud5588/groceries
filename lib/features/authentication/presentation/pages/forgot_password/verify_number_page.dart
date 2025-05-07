import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/features/authentication/presentation/widgets/button_widget.dart';
import 'package:groceries/features/authentication/presentation/widgets/otp_input_widget.dart';

import '../../../../../core/const/utils/app_responsive.dart';

class VerifyNumberPage extends StatefulWidget {
  const VerifyNumberPage({Key? key}) : super(key: key);

  @override
  _VerifyNumberPageState createState() => _VerifyNumberPageState();
}

class _VerifyNumberPageState extends State<VerifyNumberPage> {
  final int _otpFieldCount = 6;
  String _enteredOtp = '';

  void _onOtpCompleted(String otp) {
    setState(() {
      _enteredOtp = otp;
    });
    print('OTP Completed: $otp');
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
          'Verify Number',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: appHeight(5)),

            Text(
              'Verify your number',
              textAlign: TextAlign.center,
              style: AppTextStyle.heading.copyWith(fontSize: appWidth(6)),
            ),
            SizedBox(height: appHeight(1)),

            Text(
              'Enter your OTP code below',
              textAlign: TextAlign.center,
              style: AppTextStyle.body.copyWith(color: AppColors.textGrey, fontSize: appWidth(3.8)),
            ),
            SizedBox(height: appHeight(4)),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: appWidth(5)),
              child: OtpInputWidget(
                numberOfFields: _otpFieldCount,
                onCompleted: _onOtpCompleted,
              ),
            ),
            SizedBox(height: appHeight(4)),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: appWidth(5)),
              child: SizedBox(
                width: double.infinity,
                height: appHeight(7),
                child: ButtonWidget(
                  text: 'Next',
                  onPressed: _enteredOtp.length == _otpFieldCount
                      ? () {
                    print('OTP entered: $_enteredOtp');
                  }
                      : null,
                ),
              ),
            ),
            SizedBox(height: appHeight(3)),

            TextButton(
              onPressed: () {
                print('Resend code tapped');
              },
              child: Text(
                'Didn\'t receive the code? Resend a new code',
                style: AppTextStyle.body.copyWith(color: AppColors.link, fontSize: appWidth(3.8)),
              ),
            ),
            SizedBox(height: appHeight(20)),
          ],
        ),
      ),
    );
  }
}