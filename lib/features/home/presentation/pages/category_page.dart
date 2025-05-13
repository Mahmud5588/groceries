import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart' show AppColors;
import 'package:groceries/core/const/strings/text_styles.dart' show AppTextStyle;
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/features/home/presentation/widget/category_widget.dart';


class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> categories = const [
    {'name': 'vegetables', 'icon': 'assets/images/vegetables.png', 'color': Color(0xffEBFFD7)},
    {'name': 'Fruits', 'icon': 'assets/images/fruit.png', 'color': Color(0xffFFE9E5)},
    {'name': 'Beverages', 'icon': 'assets/images/beverage.png', 'color': Color(0xffFFF9E5)},
    {'name': 'Grocery', 'icon': 'assets/images/grocery.png', 'color': Color(0xffF6E5FF)},
    {'name': 'Edible oil', 'icon': 'assets/images/edibe.png', 'color': Color(0xffE5FFFB)},
    {'name': 'Household', 'icon': 'assets/images/house.png', 'color': Color(0xffFFE5F8)},
    {'name': 'Babycare', 'icon': 'assets/images/babycore.png', 'color': Color(0xffE5F7FF)},
  ];

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        title: Text(
          'categories'.tr(),
          style: theme.textTheme.headlineMedium?.copyWith(fontSize: appWidth(5), color: theme.appBarTheme.foregroundColor),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.appBarTheme.foregroundColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: theme.appBarTheme.foregroundColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: appWidth(5), vertical: appHeight(2)),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: appWidth(4),
            mainAxisSpacing: appHeight(2),
            childAspectRatio: 0.8,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return CategoryItemWidget(
              iconPath: category['icon'],
              name: category['name'],
              backgroundColor: category['color'],
            );
          },
        ),
      ),
    );
  }
}
