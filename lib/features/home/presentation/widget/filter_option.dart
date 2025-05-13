import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';

class FilterOptionWidget extends StatefulWidget {
  final IconData icon;
  final String text;
  final bool initialValue;
  final ValueChanged<bool>? onChanged;

  const FilterOptionWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.initialValue,
    this.onChanged,
  }) : super(key: key);

  @override
  _FilterOptionWidgetState createState() => _FilterOptionWidgetState();
}

class _FilterOptionWidgetState extends State<FilterOptionWidget> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        setState(() {
          _value = !_value;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(_value);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: appHeight(1.5)),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: theme.dividerColor,
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              widget.icon,
              color: theme.hintColor,
              size: appWidth(6),
            ),
            SizedBox(width: appWidth(4)),
            Expanded(
              child: Text(
                widget.text,
                style: theme.textTheme.bodyMedium?.copyWith(fontSize: appWidth(4)),
              ),
            ),
            Icon(
              _value ? Icons.check_circle : Icons.radio_button_unchecked,
              color: _value ? theme.primaryColor : theme.hintColor,
              size: appWidth(6),
            ),
          ],
        ),
      ),
    );
  }
}
