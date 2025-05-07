import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';


class NotificationSettingItemWidget extends StatefulWidget {
  final String title;
  final String description;
  final bool initialValue;
  final ValueChanged<bool>? onChanged;

  const NotificationSettingItemWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.initialValue,
    this.onChanged,
  }) : super(key: key);

  @override
  State<NotificationSettingItemWidget> createState() => _NotificationSettingItemWidgetState();
}

class _NotificationSettingItemWidgetState extends State<NotificationSettingItemWidget> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.border,
            width: 1.0,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: appHeight(1.5), horizontal: appWidth(0)), // Ichki bo'shliq (gorizontal padding MyAddressPage dan keladi)
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: AppTextStyle.body.copyWith(fontWeight: FontWeight.bold, fontSize: appWidth(4)),
                ),
                SizedBox(height: appHeight(0.5)),
                Text(
                  widget.description,
                  style: AppTextStyle.body.copyWith(color: AppColors.textGrey, fontSize: appWidth(3.5)),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Switch(
            value: _value,
            onChanged: (bool newValue) {
              setState(() {
                _value = newValue;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(newValue);
              }
            },
            activeColor: AppColors.primaryDark,
            inactiveTrackColor: AppColors.textGrey.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}