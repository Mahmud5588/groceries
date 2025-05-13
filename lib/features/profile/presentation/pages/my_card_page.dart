import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/core/route/route_names.dart';
import 'package:groceries/features/authentication/presentation/widgets/button_widget.dart';
import 'package:groceries/features/authentication/presentation/widgets/my_textfield.dart' show MyTextField;
import 'package:groceries/features/profile/presentation/widget/credit_card_widget.dart' show CreditCardWidget;

class MyCardsPage extends StatefulWidget {
  const MyCardsPage({Key? key}) : super(key: key);

  @override
  State<MyCardsPage> createState() => _MyCardsPageState();
}

class _MyCardsPageState extends State<MyCardsPage> {
  final TextEditingController _nameOnCardController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  bool _isDefault = false;

  final List<Map<String, dynamic>> cards = [
    {
      'cardType': 'Master Card',
      'lastFourDigits': '5678',
      'expiryDate': '01/22',
      'cvv': '908',
      'cardIconPath': 'assets/images/mastercard.png',
      'iconBackgroundColor': const Color(0xffFFE9E5),
      'isDefault': true,
    },
    {
      'cardType': 'Visa Card',
      'lastFourDigits': '5678',
      'expiryDate': '01/22',
      'cvv': '908',
      'cardIconPath': 'assets/images/mastercard.png',
      'iconBackgroundColor': const Color(0xffE5F7FF),
      'isDefault': false,
    },
    {
      'cardType': 'Master Card',
      'lastFourDigits': '5678',
      'expiryDate': '01/22',
      'cvv': '908',
      'cardIconPath': 'assets/images/mastercard.png',
      'iconBackgroundColor': const Color(0xffFFE9E5),
      'isDefault': false,
    },
  ];

  @override
  void dispose() {
    _nameOnCardController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  InputDecoration _buildInputDecoration(BuildContext context, {
    required String hintText,
    required IconData prefixIcon,
    int? maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
  }) {
    final theme = Theme.of(context);
    return InputDecoration(
      hintText: hintText,
      hintStyle: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor, fontSize: appWidth(3.5)),
      prefixIcon: Icon(prefixIcon, color: theme.hintColor, size: appWidth(5)),
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
      fillColor: theme.cardColor,
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
          'My Cards',
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
            icon: Icon(Icons.add_circle_outline, color: theme.appBarTheme.foregroundColor),
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.addCreditCardPage);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: appWidth(5), vertical: appHeight(2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cards.length,
              itemBuilder: (context, index) {
                final card = cards[index];
                return CreditCardWidget(
                  cardType: card['cardType'],
                  lastFourDigits: card['lastFourDigits'],
                  expiryDate: card['expiryDate'],
                  cvv: card['cvv'],
                  cardIconPath: card['cardIconPath'],
                  iconBackgroundColor: card['iconBackgroundColor'],
                  isDefault: card['isDefault'],
                  onEdit: () {
                    print('Edit card: ${card['cardType']}');
                  },
                );
              },
            ),
            SizedBox(height: appHeight(3)),

            Text(
              'Add New Card',
              style: theme.textTheme.headlineMedium?.copyWith(fontSize: appWidth(4.5)),
            ),
            SizedBox(height: appHeight(2)),

            MyTextField(
              controller: _nameOnCardController,
              texts: 'Russell Austin',
              icon: Icon(Icons.person_outline, color: theme.hintColor, size: appWidth(5)),
              keyboardType: TextInputType.name,
              decoration: _buildInputDecoration(context, hintText: 'Russell Austin', prefixIcon: Icons.person_outline),
            ),
            SizedBox(height: appHeight(1.5)),

            MyTextField(
              controller: _cardNumberController,
              texts: 'XXXX XXXX XXXX 5678',
              icon: Icon(Icons.credit_card_outlined, color: theme.hintColor, size: appWidth(5)),
              keyboardType: TextInputType.number,
              maxLines: 19,
              decoration: _buildInputDecoration(context, hintText: 'XXXX XXXX XXXX 5678', prefixIcon: Icons.credit_card_outlined),
            ),
            SizedBox(height: appHeight(1.5)),

            Row(
              children: [
                Expanded(
                  child: MyTextField(
                    controller: _expiryDateController,
                    texts: '01/22',
                    icon: Icon(Icons.calendar_today_outlined, color: theme.hintColor, size: appWidth(5)),
                    keyboardType: TextInputType.datetime,
                    maxLines: 5,
                    decoration: _buildInputDecoration(context, hintText: '01/22', prefixIcon: Icons.calendar_today_outlined),
                  ),
                ),
                SizedBox(width: appWidth(4)),
                Expanded(
                  child: MyTextField(
                    controller: _cvvController,
                    texts: '908',
                    icon: Icon(Icons.lock_outline, color: theme.hintColor, size: appWidth(5)),
                    keyboardType: TextInputType.number,
                     maxLines: 3,
                    decoration: _buildInputDecoration(context, hintText: '908', prefixIcon: Icons.lock_outline),
                  ),
                ),
              ],
            ),
            SizedBox(height: appHeight(2)),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Make default',
                  style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: appWidth(4)),
                ),
                Switch(
                  value: _isDefault,
                  onChanged: (bool newValue) {
                    setState(() {
                      _isDefault = newValue;
                    });
                  },
                  activeColor: theme.switchTheme.thumbColor?.resolve({WidgetState.selected}),
                  inactiveTrackColor: theme.switchTheme.trackColor?.resolve({WidgetState.disabled}),
                ),
              ],
            ),
            SizedBox(height: appHeight(4)),

            SizedBox(
              width: double.infinity,
              height: appHeight(7),
              child: ButtonWidget(
                text: 'Save settings',
                onPressed: () {
                  print('Save settings tapped');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
