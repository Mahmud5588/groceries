import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/core/const/strings/app_strings.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/core/di/service_locator.dart';
import 'package:groceries/core/route/route_names.dart';
import 'package:groceries/core/theme/theme_bloc.dart';
import 'package:groceries/core/theme/theme_event.dart';
import 'package:groceries/core/theme/theme_state.dart';
import 'package:groceries/features/authentication/domain/entities/user_entites.dart';
import 'package:groceries/features/authentication/presentation/bloc/event.dart';
import 'package:groceries/features/authentication/presentation/bloc/logout/logout_bloc.dart';
import 'package:groceries/features/authentication/presentation/bloc/user/user_bloc.dart';
import 'package:groceries/features/authentication/presentation/bloc/user/user_event.dart';
import 'package:groceries/features/authentication/presentation/bloc/user/user_state.dart';
import 'package:groceries/features/authentication/presentation/widgets/profile_item_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<UserProfileBloc>().add(FetchUserProfile());
  }

  ImageProvider _getImageProvider(String? profilePictureUrl) {
    if (profilePictureUrl != null && profilePictureUrl.isNotEmpty) {
      Uri? uri = Uri.tryParse(profilePictureUrl);
      if (uri != null && uri.isAbsolute && (uri.scheme == 'http' || uri.scheme == 'https')) {
        return NetworkImage(profilePictureUrl);
      } else {
        print('Noto\'g\'ri yoki to\'liqsiz profil rasmi URL manzili: $profilePictureUrl. Standart rasmga qaytildi.');
        return const AssetImage('assets/images/peach.png');
      }
    }
    return const AssetImage('assets/images/peach.png');
  }

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, userState) {
            UserEntities? currentUser;
            if (userState is UserProfileLoaded) {
              currentUser = userState.user;
            } else if (userState is UserProfileUpdateSuccess) {
              currentUser = userState.props as UserEntities;
            }

            String displayName = (currentUser != null && currentUser.first_name.isNotEmpty)
                ? '${currentUser.first_name} ${currentUser.last_name ?? ''}'.trim()
                : 'Foydalanuvchi'.tr();
            String displayEmail = currentUser?.email ?? 'Email mavjud emas'.tr();
            ImageProvider profileImageProvider = _getImageProvider(currentUser?.profile_picture);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: appHeight(3)),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: appWidth(12),
                      backgroundImage: profileImageProvider,
                      onBackgroundImageError: (exception, stackTrace) {
                        print("CircleAvatar rasm yuklashda xatolik: $exception");
                      },
                      backgroundColor: theme.dividerColor,
                    ),
                    Positioned(
                      right: appWidth(0),
                      bottom: appHeight(0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.aboutMePage).then((_) {
                            context.read<UserProfileBloc>().add(FetchUserProfile());
                          });
                        },
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
                    ),
                  ],
                ),
                SizedBox(height: appHeight(2)),
                Text(
                  displayName,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontSize: appWidth(5),
                  ),
                ),
                SizedBox(height: appHeight(0.5)),
                Text(
                  displayEmail,
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
                        text: 'aboutMe'.tr(),
                        onPressed: () {
                          Navigator.pushNamed(context, RouteNames.aboutMePage).then((_) {
                            context.read<UserProfileBloc>().add(FetchUserProfile());
                          });
                        },
                      ),
                      ProfileMenuItemWidget(
                        icon: Icons.shopping_bag_outlined,
                        text: 'myOrders'.tr(),
                        onPressed: () {
                          Navigator.pushNamed(context, RouteNames.homePage);
                        },
                      ),
                      ProfileMenuItemWidget(
                        icon: Icons.favorite_border,
                        text: 'myFavorites'.tr(),
                        onPressed: () {
                          Navigator.pushNamed(context, RouteNames.favoritesPage);
                        },
                      ),
                      ProfileMenuItemWidget(
                        icon: Icons.language,
                        text: AppStrings.language.tr(),
                        onPressed: () {
                          Navigator.pushNamed(context, RouteNames.languagePage);
                        },
                      ),
                      ProfileMenuItemWidget(
                        icon: Icons.location_on_outlined,
                        text: 'myAddress'.tr(),
                        onPressed: () {
                          Navigator.pushNamed(context, RouteNames.addressPage);
                        },
                      ),
                      ProfileMenuItemWidget(
                        icon: Icons.credit_card_outlined,
                        text: 'creditCards'.tr(),
                        onPressed: () {
                          Navigator.pushNamed(context, RouteNames.myCardPage);
                        },
                      ),
                      ProfileMenuItemWidget(
                        icon: Icons.account_balance_wallet_outlined,
                        text: 'transactions'.tr(),
                        onPressed: () {
                          Navigator.pushNamed(context, RouteNames.transactionPage);
                        },
                      ),
                      ProfileMenuItemWidget(
                        icon: Icons.notifications_none_outlined,
                        text: 'notifications'.tr(),
                        onPressed: () {
                          Navigator.pushNamed(context, RouteNames.notificationPage);
                        },
                      ),
                      ProfileMenuItemWidget(
                        icon: Icons.mode_night_outlined,
                        text: AppStrings.mode.tr(),
                        element: BlocBuilder<ThemeBloc, ThemeState>(
                          builder: (context, themeBlocState) {
                            return Switch(
                              value: themeBlocState.themeMode == ThemeMode.dark,
                              onChanged: (newValue) {
                                sl<ThemeBloc>().add(ToggleThemeEvent());
                              },
                              activeColor: theme.switchTheme.thumbColor?.resolve({WidgetState.selected}),
                              inactiveThumbColor: theme.switchTheme.thumbColor?.resolve({WidgetState.disabled}),
                              activeTrackColor: theme.switchTheme.trackColor?.resolve({WidgetState.selected}),
                              inactiveTrackColor: theme.switchTheme.trackColor?.resolve({WidgetState.disabled}),
                            );
                          },
                        ),
                        onPressed: () {
                          sl<ThemeBloc>().add(ToggleThemeEvent());
                        },
                      ),
                      ProfileMenuItemWidget(
                        icon: Icons.logout,
                        text: 'signOut'.tr(),
                        onPressed: () {
                          context.read<LogoutBloc>().add(LogoutEvent());
                          Navigator.pushNamedAndRemoveUntil(context, RouteNames.signIn, (route) => false);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}