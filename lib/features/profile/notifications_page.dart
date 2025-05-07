import 'package:flutter/material.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/features/profile/presentation/widget/notifications_widget.dart' show NotificationSettingItemWidget;

import '../../core/const/colors/app_colors.dart' show AppColors;
import '../authentication/presentation/widgets/button_widget.dart' show ButtonWidget;

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final Map<String, bool> _notificationSettings = {
    'Allow Notifications': true,
    'Email Notifications': false,
    'Order Notifications': false,
    'General Notifications': true,
  };

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundPink,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPink,
        elevation: 0,
        title: Text(
          'Notifications',
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

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _notificationSettings.length,
              itemBuilder: (context, index) {
                final settingTitle = _notificationSettings.keys.elementAt(index);
                final initialValue = _notificationSettings.values.elementAt(index);

                String description;
                switch(settingTitle) {
                  case 'Allow Notifications':
                    description = 'Lorem ipsum dolor sit amet, consetetur sadi pscing elitr, sed diam nonumy...';
                    break;
                  case 'Email Notifications':
                    description = 'Lorem ipsum dolor sit amet, consetetur sadi pscing elitr, sed diam nonumy...';
                    break;
                  case 'Order Notifications':
                    description = 'Lorem ipsum dolor sit amet, consetetur sadi pscing elitr, sed diam nonumy...';
                    break;
                  case 'General Notifications':
                    description = 'Lorem ipsum dolor sit amet, consetetur sadi pscing elitr, sed diam nonumy...';
                    break;
                  default:
                    description = 'Notification description...';
                }


                return NotificationSettingItemWidget(
                  title: settingTitle,
                  description: description,
                  initialValue: initialValue,
                  onChanged: (newValue) {
                    // Switch holati o'zgarganda _notificationSettings mapini yangilash
                    setState(() {
                      _notificationSettings[settingTitle] = newValue;
                    });
                    print('$settingTitle changed to $newValue');
                  },
                );
              },
            ),
            SizedBox(height: appHeight(4)), // List va tugma orasidagi bo'shliq

            // Save Settings Button
            SizedBox(
              width: double.infinity, // Kenglikni to'ldirish
              height: appHeight(7),
              child: ButtonWidget(
                text: 'Save settings',
                onPressed: () {
                  // Sozlamalarni saqlash logikasi
                  print('Save settings tapped');
                  print('Current settings: $_notificationSettings');
                  // _notificationSettings mapidagi holatni serverga yuborishingiz mumkin
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}