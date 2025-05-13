import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
    {'title': "welcome".tr(), 'image': 'assets/images/splash1.png'},
    {'title': "splash1".tr(), 'image': 'assets/images/splash2.png'},
    {'title': "splash2".tr(), 'image': 'assets/images/splash3.png'},
    {'title': "splash3".tr(), 'image': 'assets/images/splash4.png'},
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
              height: AppResponsive.height(7), // Adjusted height slightly
              child: ElevatedButton(
                onPressed: _navigateToNextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  _isLastPage ? "getStarted".tr() : "continue".tr(),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSplashPage({
    required String title,
    required String imagePath,
    required bool isCurrentPage,
  }) {
    return SizedBox(
      width: AppResponsive.screenWidth,
      height: AppResponsive.screenHeight,
      child: Stack(
        children: [
          Positioned.fill(child: Image.asset(imagePath, fit: BoxFit.cover)),
          Positioned(
            top: AppResponsive.height(10),
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(5)),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 20,
                  color: Theme.of(context).textTheme.headlineMedium?.color,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[SizedBox(height: AppResponsive.height(2))],
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
            color:
                _currentPage == index
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).hintColor?.withOpacity(0.5),
          ),
        );
      }),
    );
  }
}
