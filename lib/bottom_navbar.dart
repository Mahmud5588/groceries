import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/features/home/presentation/pages/home.dart';
import 'package:groceries/features/profile/profile_page.dart';

import 'core/const/utils/app_responsive.dart';

class MyBottomNavbarWidget extends StatefulWidget {
  const MyBottomNavbarWidget({super.key});

  @override
  State<MyBottomNavbarWidget> createState() => _MyBottomNavbarWidgetState();
}

class _MyBottomNavbarWidgetState extends State<MyBottomNavbarWidget> {
  int currentPage = 0;
  List<Widget> pages = [
    const HomePage(),
    const Center(child: Text("Account Page")),
    const ProfilePage(),
    const Center(child: Text("Carts Page")),
  ];

  @override
  Widget build(BuildContext context) {

    AppResponsive.init(context);

    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primaryDark,
        unselectedItemColor: AppColors.textBlack,
        currentIndex: currentPage,
        selectedLabelStyle: AppTextStyle.button.copyWith(fontSize: appWidth(3.5)),
        unselectedLabelStyle: AppTextStyle.button.copyWith(fontSize: appWidth(3)),
        type: BottomNavigationBarType.fixed,
        onTap: (int newIndex) {
          setState(() {
            currentPage = newIndex;
          });
        },
        items: [
          bottomNavigationBarItemWidget(
            label: "Home",
            iconData: Icons.home,
            index: 0,
            selectedIndex: currentPage,
          ),
          bottomNavigationBarItemWidget(
            label: "Favorite",
            iconData: Icons.favorite_border,
            index: 1,
            selectedIndex: currentPage,
          ),
          bottomNavigationBarItemWidget(
            label: "Account",
            iconData: Icons.account_circle_outlined,
            index: 2,
            selectedIndex: currentPage,
          ),
          bottomNavigationBarItemWidget(
            label: "Carts",
            iconData: Icons.shopping_bag_outlined,
            index: 3,
            selectedIndex: currentPage,
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem bottomNavigationBarItemWidget({
    required String label,
    required IconData iconData,
    required int index,
    required int selectedIndex,
  }) {

    final bool isSelected = index == selectedIndex;

    return BottomNavigationBarItem(
      backgroundColor: AppColors.backgroundWhite,
      label: label,
      icon: isSelected
          ?

      Container(
        padding: EdgeInsets.all(appWidth(2)),
        decoration: BoxDecoration(
          color: AppColors.primaryDark,
          shape: BoxShape.circle,
        ),
        child: Transform.scale(
          scale: 1.2,
          child: Icon(
            iconData,
            color: AppColors.backgroundWhite,
            size: appWidth(6),
          ),
        ),
      )
          :

      Icon(
        iconData,
        color: AppColors.textBlack,
        size: appWidth(6),
      ),
    );
  }
}