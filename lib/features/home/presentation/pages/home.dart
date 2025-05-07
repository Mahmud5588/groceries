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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(
            top: 60,
            left: 16,
            right: 16,
            bottom: 10,
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: AppStrings.searchKeyword,
              prefixIcon: const Icon(Icons.search),
              suffix: IconButton(
                icon: const Icon(Icons.tune),
                onPressed: () {},
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: Colors.white),
              ),
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
                            // Image as background
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                item['image'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                            // Title text on top of the image
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  item['title'],
                                  style: AppTextStyle.heading.copyWith(
                                    color: AppColors.textBlack,
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
                    Text(AppStrings.category, style: AppTextStyle.heading),
                     IconButton(icon:Icon(Icons.navigate_next, size: 40), onPressed: (){
                       Navigator.pushNamed(context, RouteNames.categoryPage);
                     }),
                  ],
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: category.categories.length,
                    itemBuilder: (context, index) {
                      final categories = category.categories[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: AppColors.backgroundWhite,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  categories['image'],
                                  fit: BoxFit.contain,
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(categories['title'], style: AppTextStyle.body),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: AppResponsive.height(2)),
                Text("Featured Products", style: AppTextStyle.heading),
                GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
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
                        Navigator.pushNamed(context, RouteNames.productsPage);
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
