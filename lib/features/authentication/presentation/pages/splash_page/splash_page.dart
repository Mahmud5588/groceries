import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/app_strings.dart';
import 'package:groceries/core/route/route_names.dart';
import '../../../../../core/const/utils/app_responsive.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final PageController _pageController = PageController(initialPage: 0);
  final List<Map<String, dynamic>> _splashData = [
    {
      'title': AppStrings.welcome,
      'image': 'assets/images/splash1.png',
    },
    {
      'title': AppStrings.splash1,
      'image': 'assets/images/splash2.png',
    },
    {
      'title': AppStrings.splash2,
      'image': 'assets/images/splash3.png',
    },
    {
      'title': AppStrings.splash3,
      'image': 'assets/images/splash4.png',
    },
  ];
  int _currentPage = 0;
  bool _isLastPage = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppResponsive.init(context);
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    setState(() {
      _currentPage = _pageController.page?.round() ?? 0;
      _isLastPage = _currentPage == _splashData.length - 1;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _pageController.removeListener(_onPageChanged);
    super.dispose();
  }

  void _navigateToNextPage() {
    if (_currentPage < _splashData.length - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushNamed(context, RouteNames.signIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _splashData.length,
            itemBuilder: (context, index) {
              return _buildSplashPage(
                title: _splashData[index]['title'] ?? '',
                imagePath: _splashData[index]['image'] ?? '',
                isCurrentPage: index == _currentPage,
              );
            },
          ),
          Positioned(
            bottom: AppResponsive.height(15),
            left: 0,
            right: 0,
            child: _buildPageIndicator(),
          ),
          Positioned(
            bottom: AppResponsive.height(4),
            left: AppResponsive.width(5),
            right: AppResponsive.width(5),
            child: SizedBox(
              height: AppResponsive.height(6),
              child: ElevatedButton(
                onPressed: _navigateToNextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  _isLastPage ? AppStrings.getStarted : "Continue",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildSplashPage(
      {required String title, required String imagePath, required bool isCurrentPage}) {
    return SizedBox(
      width: AppResponsive.screenWidth,
      height: AppResponsive.screenHeight,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: AppResponsive.height(10),
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(5)),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: AppResponsive.height(2)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(_splashData.length, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _currentPage == index ? 24 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: _currentPage == index ? AppColors.primaryDark : Colors.grey,
          ),
        );
      }),
    );
  }
}

