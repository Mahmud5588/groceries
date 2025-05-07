import 'package:flutter/material.dart';

appWidth(double number)=>AppResponsive.width(number);
appHeight(double number)=>AppResponsive.height(number);
class AppResponsive {
  static late double screenHeight;
  static late double screenWidth;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
  }

  static double height(double number) => screenHeight * number / 100;
  static double width(double number) => screenWidth * number / 100;
}
