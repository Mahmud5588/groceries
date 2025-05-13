import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/features/authentication/presentation/widgets/button_widget.dart';


class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.appBarTheme.foregroundColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: appHeight(35),
              child: Center(
                child: Image.asset(
                  'assets/images/peach.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: appWidth(5),
                vertical: appHeight(2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$2.22',
                        style: AppTextStyle.heading.copyWith(
                          color: theme.primaryColor,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.favorite_border, color: theme.hintColor),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: appHeight(1)),
                  Text(
                    'Organic Lemons',
                    style: theme.textTheme.headlineMedium,
                  ),
                  SizedBox(height: appHeight(1)),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: appWidth(4)),
                      Icon(Icons.star, color: Colors.amber, size: appWidth(4)),
                      Icon(Icons.star, color: Colors.amber, size: appWidth(4)),
                      Icon(Icons.star, color: Colors.amber, size: appWidth(4)),
                      Icon(Icons.star_half, color: Colors.amber, size: appWidth(4)),
                      SizedBox(width: appWidth(2)),
                      Text(
                        '4.5',
                        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: appWidth(2)),
                      Text(
                        '(89 reviews)',
                        style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
                      ),
                    ],
                  ),
                  SizedBox(height: appHeight(2)),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Organic Mountain works as a seller for many organic'
                              ' growers of organic lemons. Organic lemons are easy to spot in your '
                              'produce aisle. '
                              'They are just like regular lemons, '
                              'but they will usually have a few more scars on the outside of the'
                              ' lemon skin. Organic lemons are considered to be the world\'s '
                              'finest lemon for juicing. ',
                          style: theme.textTheme.bodyMedium,
                        ),
                        TextSpan(
                          text: 'more',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: appHeight(3)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quantity',
                        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: theme.dividerColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove, color: theme.hintColor),
                              onPressed: () {},
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: appWidth(4)),
                              child: Text(
                                '3',
                                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add, color: theme.primaryColor),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: appHeight(3)),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(appWidth(5)),
        child: SizedBox(
          height: appHeight(7),
          child: ButtonWidget(
            text: 'Add to cart',
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
