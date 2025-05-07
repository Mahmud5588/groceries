import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart' show AppTextStyle;
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/features/home/presentation/widget/category_widget.dart';


class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  // Sample category data (PNG fayl yo'llari bilan)
  final List<Map<String, dynamic>> categories = const [
    {'name': 'Vegetables', 'icon': 'assets/images/vegetables.png', 'color': Color(0xffEBFFD7)},
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

    return Scaffold(
      backgroundColor: AppColors.border,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        title: Text(
          'Categories',
          style: AppTextStyle.heading.copyWith(fontSize: appWidth(5)),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textBlack),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: AppColors.textBlack),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: appWidth(4), vertical: appHeight(2)),
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