import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';

class OtpInputWidget extends StatefulWidget {
  final int numberOfFields;
  final ValueChanged<String> onCompleted;

  const OtpInputWidget({
    Key? key,
    required this.numberOfFields,
    required this.onCompleted,
  }) : super(key: key);

  @override
  _OtpInputWidgetState createState() => _OtpInputWidgetState();
}

class _OtpInputWidgetState extends State<OtpInputWidget> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  late List<String> _otp;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.numberOfFields, (_) => TextEditingController());
    _focusNodes = List.generate(widget.numberOfFields, (_) => FocusNode());
    _otp = List.generate(widget.numberOfFields, (_) => '');

    for (int i = 0; i < widget.numberOfFields - 1; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.length == 1) {
          FocusScope.of(context).nextFocus();
        }
      });
    }

    _controllers[widget.numberOfFields - 1].addListener(() {
      if (_controllers[widget.numberOfFields - 1].text.length == 1) {
        _otp = _controllers.map((controller) => controller.text).toList();
        if (!_otp.contains('')) {
          widget.onCompleted(_otp.join());
          _focusNodes[widget.numberOfFields - 1].unfocus();
        }
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void pasteCode(String code) {
    if (code.length == widget.numberOfFields) {
      for (int i = 0; i < widget.numberOfFields; i++) {
        _controllers[i].text = code[i];
      }
      _otp = _controllers.map((controller) => controller.text).toList();
      widget.onCompleted(_otp.join());
      _focusNodes[widget.numberOfFields - 1].unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(widget.numberOfFields, (index) {
        return Container(
          width: appWidth(12),
          height: appWidth(14),
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Center(
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: AppTextStyle.heading.copyWith(fontSize: appWidth(5)),
              maxLength: 1,
              cursorColor: AppColors.primaryDark,
              decoration: const InputDecoration(
                border: InputBorder.none,
                counterText: "",
              ),
              onChanged: (value) {
                if (value.length > 1) {
                  _controllers[index].text = value.substring(0, 1);
                  value = value.substring(0, 1);
                }

                _otp[index] = value;

                if (value.isNotEmpty) {
                  if (index < widget.numberOfFields - 1) {
                    FocusScope.of(context).nextFocus();
                  } else if (index == widget.numberOfFields - 1) {
                    _otp = _controllers.map((controller) => controller.text).toList();
                    if (!_otp.contains('')) {
                      widget.onCompleted(_otp.join());
                      _focusNodes[widget.numberOfFields - 1].unfocus();
                    }
                  }
                } else { // value.isEmpty
                  if (index > 0) {
                    FocusScope.of(context).previousFocus();
                    _controllers[index - 1].text = '';
                  }
                }
              },
            ),
          ),
        );
      }),
    );
  }
}