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

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPink,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textBlack),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: appHeight(35),
              color: AppColors.backgroundPink,
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
                          color: AppColors.primaryDark,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite_border, color: AppColors.textGrey),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: appHeight(1)),
                  Text(
                    'Organic Lemons',
                    style: AppTextStyle.heading,
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
                        style: AppTextStyle.body.copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: appWidth(2)),
                      Text(
                        '(89 reviews)',
                        style: AppTextStyle.body.copyWith(color: AppColors.textGrey),
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
                          style: AppTextStyle.body,
                        ),
                        TextSpan(
                          text: 'more',
                          style: AppTextStyle.body.copyWith(
                            color: AppColors.link,
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
                        style: AppTextStyle.body.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.border),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, color: AppColors.textGrey),
                              onPressed: () {},
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: appWidth(4)),
                              child: Text(
                                '3',
                                style: AppTextStyle.body.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, color: AppColors.primaryDark),
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