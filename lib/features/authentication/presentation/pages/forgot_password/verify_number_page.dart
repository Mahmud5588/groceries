import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/features/authentication/presentation/widgets/button_widget.dart';
import 'package:groceries/features/authentication/presentation/widgets/otp_input_widget.dart';

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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        title: Text(
          "verifyNumber".tr(),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: appWidth(5), color: Theme.of(context).appBarTheme.foregroundColor),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).appBarTheme.foregroundColor),
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
              "verifyNumber".tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: appWidth(6)),
            ),
            SizedBox(height: appHeight(1)),

            Text(
              "enterOtp".tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).hintColor, fontSize: appWidth(3.8)),
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
                  text: 'next'.tr(),
                  onPressed: () {
                    print('Next tapped');
                  },
                ),
              ),
            ),
            SizedBox(height: appHeight(3)),

            TextButton(
              onPressed: () {
                print('Resend code tapped');
              },
              child: Text(
                'didntResive'.tr(),
                style: AppTextStyle.body.copyWith(color: Theme.of(context).primaryColor, fontSize: appWidth(3.8)),
              ),
            ),

            SizedBox(height: appHeight(20)),
          ],
        ),
      ),
    );
  }
}
