
import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/core/route/route_names.dart';
import 'package:groceries/features/authentication/presentation/widgets/profile_item_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: appHeight(3)),

            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: appWidth(12),
                  backgroundImage: AssetImage('assets/images/peach.png'),
                  backgroundColor: AppColors.border,
                ),
                Positioned(
                  right: appWidth(0),
                  bottom: appHeight(0),
                  child: Container(
                    padding: EdgeInsets.all(appWidth(1)),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryDark,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: AppColors.backgroundWhite,
                      size: appWidth(4),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: appHeight(2)),

            Text(
              'Olivia Austin',
              style: AppTextStyle.heading.copyWith(fontSize: appWidth(5)),
            ),
            SizedBox(height: appHeight(0.5)),

            Text(
              'oliviaaustin@gmail.com',
              style: AppTextStyle.body.copyWith(
                fontSize: appWidth(3.5),
                color: AppColors.textGrey,
              ),
            ),
            SizedBox(height: appHeight(4)),

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ProfileMenuItemWidget(
                    icon: Icons.person_outline,
                    text: 'About me',
                    onPressed: () {
                      Navigator.pushNamed(context, RouteNames.aboutMePage);
                    },
                  ),
                  ProfileMenuItemWidget(
                    icon: Icons.shopping_bag_outlined,
                    text: 'My Orders',
                    onPressed: () {
                      print('My Orders tapped');
                    },
                  ),
                  ProfileMenuItemWidget(
                    icon: Icons.favorite_border,
                    text: 'My Favorites',
                    onPressed: () {
                      print('My Favorites tapped');
                    },
                  ),
                  ProfileMenuItemWidget(
                    icon: Icons.location_on_outlined,
                    text: 'My Address',
                    onPressed: () {
                      Navigator.pushNamed(context,RouteNames.addressPage);
                    },
                  ),
                  ProfileMenuItemWidget(
                    icon: Icons.credit_card_outlined,
                    text: 'Credit Cards',
                    onPressed: () {
                      Navigator.pushNamed(context, RouteNames.myCardPage);
                    },
                  ),
                  ProfileMenuItemWidget(
                    icon: Icons.account_balance_wallet_outlined,
                    text: 'Transactions',
                    onPressed: () {
                      Navigator.pushNamed(context, RouteNames.transactionPage);
                    },
                  ),
                  ProfileMenuItemWidget(
                    icon: Icons.notifications_none_outlined,
                    text: 'Notifications',
                    onPressed: () {
                      Navigator.pushNamed(context, RouteNames.notificationPage);
                    },
                  ),
                  ProfileMenuItemWidget(
                    icon: Icons.logout,
                    text: 'Sign out',
                    onPressed: () {
                      print('Sign out tapped');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}