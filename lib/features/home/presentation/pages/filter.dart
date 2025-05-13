import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/features/authentication/presentation/widgets/button_widget.dart';
import 'package:groceries/features/authentication/presentation/widgets/my_textfield.dart';
import 'package:groceries/features/home/presentation/widget/filter_option.dart';

class ApplyFiltersPage extends StatefulWidget {
  const ApplyFiltersPage({Key? key}) : super(key: key);

  @override
  State<ApplyFiltersPage> createState() => _ApplyFiltersPageState();
}

class _ApplyFiltersPageState extends State<ApplyFiltersPage> {
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();

  double _starRating = 4.0;

  bool _discountSelected = false;
  bool _freeShippingSelected = false;
  bool _sameDayDeliverySelected = false;


  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  InputDecoration _buildInputDecoration(BuildContext context, {
    required String hintText,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).hintColor, fontSize: appWidth(3.5)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: Theme.of(context).cardColor,
      contentPadding: EdgeInsets.symmetric(vertical: appHeight(2), horizontal: appWidth(4)),
      counterText: "",
    );
  }

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
          'applyFilters'.tr(),
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
            icon: Icon(Icons.refresh, color: theme.appBarTheme.foregroundColor),
            onPressed: () {
              print('Refresh filters tapped');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: appWidth(5), vertical: appHeight(2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'priceRange'.tr(),
              style: theme.textTheme.headlineMedium?.copyWith(fontSize: appWidth(4.5)),
            ),
            SizedBox(height: appHeight(2)),
            Row(
              children: [
                Expanded(
                  child: MyTextField(
                    controller: _minPriceController,
                    texts: 'min'.tr(),
                    keyboardType: TextInputType.number,
                    decoration: _buildInputDecoration(context, hintText: 'min'.tr()),
                  ),
                ),
                SizedBox(width: appWidth(4)),
                Expanded(
                  child: MyTextField(
                    controller: _maxPriceController,
                    texts: 'max'.tr(),
                    keyboardType: TextInputType.number,
                    decoration: _buildInputDecoration(context, hintText: 'max'.tr(),
                  ),
                )),
              ],
            ),
            SizedBox(height: appHeight(4)),

            Text(
              'starRating'.tr(),
              style: theme.textTheme.headlineMedium?.copyWith(fontSize: appWidth(4.5)),
            ),
            SizedBox(height: appHeight(2)),
            Row(
              children: [
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < _starRating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: appWidth(6),
                    );
                  }),
                ),
                SizedBox(width: appWidth(4)),
                Expanded(
                  child: Text(
                    '${_starRating.toInt()} stars',
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor, fontSize: appWidth(3.8)),
                  ),
                ),
              ],
            ),
            SizedBox(height: appHeight(4)),

            Text(
              'others'.tr(),
              style: theme.textTheme.headlineMedium?.copyWith(fontSize: appWidth(4.5)),
            ),
            SizedBox(height: appHeight(2)),

            FilterOptionWidget(
              icon: Icons.discount_outlined,
              text: 'discount'.tr(),
              initialValue: _discountSelected,
              onChanged: (newValue) {
                setState(() {
                  _discountSelected = newValue;
                });
                print('Discount: $_discountSelected');
              },
            ),
            FilterOptionWidget(
              icon: Icons.local_shipping_outlined,
              text: 'freeShipping'.tr(),
              initialValue: _freeShippingSelected,
              onChanged: (newValue) {
                setState(() {
                  _freeShippingSelected = newValue;
                });
                print('Free shipping: $_freeShippingSelected');
              },
            ),
            FilterOptionWidget(
              icon: Icons.delivery_dining_outlined,
              text: 'sameDayDelivery'.tr(),
              initialValue: _sameDayDeliverySelected,
              onChanged: (newValue) {
                setState(() {
                  _sameDayDeliverySelected = newValue;
                });
                print('Same day delivery: $_sameDayDeliverySelected');
              },
            ),
            SizedBox(height: appHeight(4)),

            SizedBox(
              width: double.infinity,
              height: appHeight(7),
              child: ButtonWidget(
                text: 'applyFilter'.tr(),
                onPressed: () {
                  print('Apply filter tapped');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
