import 'package:flutter/material.dart';
import 'package:groceries/core/const/strings/app_strings.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/core/di/service_locator.dart';
import 'package:groceries/core/route/route_names.dart';
import 'package:groceries/core/theme/theme_bloc.dart';
import 'package:groceries/core/theme/theme_event.dart';
import 'package:groceries/core/theme/theme_state.dart';
import 'package:groceries/features/authentication/presentation/widgets/profile_item_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
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
                  backgroundColor: theme.dividerColor,
                ),
                Positioned(
                  right: appWidth(0),
                  bottom: appHeight(0),
                  child: Container(
                    padding: EdgeInsets.all(appWidth(1)),
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: theme.colorScheme.onPrimary,
                      size: appWidth(4),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: appHeight(2)),

            Text(
              'Olivia Austin',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontSize: appWidth(5),
              ),
            ),
            SizedBox(height: appHeight(0.5)),

            Text(
              'oliviaaustin@gmail.com',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: appWidth(3.5),
                color: theme.hintColor,
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
                      Navigator.pushNamed(context, RouteNames.favoritesPage);
                    },
                  ),
                  ProfileMenuItemWidget(
                    icon: Icons.language,
                    text: AppStrings.language,
                    onPressed: (){
                      Navigator.pushNamed(context, RouteNames.languagePage);
                    },
                  ),
                  ProfileMenuItemWidget(
                    icon: Icons.location_on_outlined,
                    text: 'My Address',
                    onPressed: () {
                      Navigator.pushNamed(context, RouteNames.addressPage);
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
                    icon: Icons.mode_night_outlined,
                    text: AppStrings.mode,
                    element: BlocBuilder<ThemeBloc, ThemeState>(
                      builder: (context, state) {
                        return Switch(
                          value: state.themeMode == ThemeMode.dark,
                          onChanged: (newValue) {
                            sl<ThemeBloc>().add(ToggleThemeEvent());
                          },
                          activeColor: theme.switchTheme.thumbColor?.resolve({
                            WidgetState.selected,
                          }),
                          inactiveThumbColor: theme.switchTheme.thumbColor
                              ?.resolve({WidgetState.disabled}),
                          activeTrackColor: theme.switchTheme.trackColor
                              ?.resolve({WidgetState.selected}),
                          inactiveTrackColor: theme.switchTheme.trackColor
                              ?.resolve({
                                WidgetState.disabled,
                              }),
                        );
                      },
                    ),
                    onPressed: () {
                      sl<ThemeBloc>().add(ToggleThemeEvent());
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
