import 'package:flutter/material.dart';
import 'package:groceries/core/const/strings/text_styles.dart';

import '../../../../core/const/colors/app_colors.dart';
class ButtonWidget extends StatelessWidget {
  String text;
  Function()? onPressed;
  ButtonWidget({super.key,required this.text,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed!();
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient:  LinearGradient(
            colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyle.button.copyWith(color: Theme.of(context).scaffoldBackgroundColor),
          ),
        ),
      ),
    );
  }
}
