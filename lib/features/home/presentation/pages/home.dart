import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:groceries/core/const/strings/app_strings.dart';
import 'package:groceries/core/route/route_names.dart';
import 'package:groceries/features/home/presentation/widget/category_list.dart';
import 'package:groceries/features/home/presentation/widget/featured.dart';
import '../../../../../core/const/utils/app_responsive.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  Categories category = Categories();
  final List<Map<String, dynamic>> _items = [
    {
      "title": "20% off on your first purchase",
      "image": "assets/images/home.png",
    },
    {
      "title": "Special offer! Buy one get one free",
      "image": "assets/images/home.png",
    },
    {
      "title": "Limited time offer - 50% off!",
      "image": "assets/images/home.png",
    },
  ];
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    setState(() {
      _currentPage = _pageController.page?.round() ?? 0;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _pageController.removeListener(_onPageChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(
            top: 60,
            left: 16,
            right: 16,
            bottom: 10,
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText:"searchKeyword".tr(),
              hintStyle: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
              prefixIcon: Icon(Icons.search, color: theme.hintColor),
              suffixIcon: IconButton(
                icon: Icon(Icons.tune, color: theme.hintColor),
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.filterPage);
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: theme.cardColor,
              contentPadding: EdgeInsets.symmetric(vertical: AppResponsive.height(1.5), horizontal: AppResponsive.width(4)),
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20.0),
          child: Container(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: AppResponsive.height(25),
                  child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return SizedBox(
                        width: AppResponsive.screenWidth,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                item['image'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  item['title'],
                                  style: theme.textTheme.headlineMedium?.copyWith(
                                    color: theme.textTheme.headlineMedium?.color,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: AppResponsive.height(2)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("category".tr(), style: theme.textTheme.headlineMedium),
                    IconButton(
                      icon:Icon(Icons.navigate_next, size: 40, color: theme.textTheme.headlineMedium?.color),
                      onPressed: (){
                        Navigator.pushNamed(context, RouteNames.categoryPage);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: AppResponsive.height(14),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: category.categories.length,
                    itemBuilder: (context, index) {
                      final categories = category.categories[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: appWidth(2)),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: AppResponsive.width(7),
                              backgroundColor: theme.cardColor,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  categories['image'],
                                  fit: BoxFit.contain,
                                  width: AppResponsive.width(6),
                                  height: AppResponsive.width(6),
                                ),
                              ),
                            ),
                            SizedBox(height: AppResponsive.height(0.5)),
                            Text(categories['title'], style: theme.textTheme.bodyMedium),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: AppResponsive.height(2)),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("featuredProducts".tr(), style: theme.textTheme.headlineMedium)),
                SizedBox(height: AppResponsive.height(1)),
                GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: AppResponsive.height(2),
                  crossAxisSpacing: AppResponsive.width(4),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 0.6,
                  children:  [
                    FeaturedProductCard(
                      image: 'assets/images/peach.png',
                      name: 'Apple',
                      price: '\$3.00',
                      unit: '1 kg',
                      onPressed: (){},
                    ),
                    FeaturedProductCard(
                      image: 'assets/images/peach.png',
                      name: 'Orange',
                      price: '\$2.50',
                      unit: '1.5 kg',
                      isNew: true,
                      onPressed: (){
                        Navigator.pushNamed(context, RouteNames.productPage);
                      },
                    ),
                    FeaturedProductCard(
                      image: 'assets/images/peach.png',
                      name: 'Banana',
                      price: '\$1.80',
                      unit: '1 bunch',
                      onPressed: (){},
                    ),
                    FeaturedProductCard(
                      image: 'assets/images/peach.png',
                      name: 'Grape',
                      price: '\$4.00',
                      unit: '500 g',
                      onPressed: (){},
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
