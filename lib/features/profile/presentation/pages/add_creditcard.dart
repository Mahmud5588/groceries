import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/features/authentication/presentation/widgets/button_widget.dart';
import 'package:groceries/features/authentication/presentation/widgets/my_textfield.dart';
import 'package:groceries/features/profile/presentation/widget/credit_card_preview.dart' show CreditCardPreviewWidget;


class AddCreditCardPage extends StatefulWidget {
  const AddCreditCardPage({Key? key}) : super(key: key);

  @override
  State<AddCreditCardPage> createState() => _AddCreditCardPageState();
}

class _AddCreditCardPageState extends State<AddCreditCardPage> {
  final TextEditingController _nameOnCardController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _monthYearController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  bool _saveCard = false;

  String _displayCardNumber = 'XXXX XXXX XXXX XXXX';
  String _displayCardHolderName = 'CARD HOLDER NAME';
  String _displayExpiryDate = 'MM/YY';


  @override
  void initState() {
    super.initState();
    _nameOnCardController.addListener(_updateCardPreview);
    _cardNumberController.addListener(_updateCardPreview);
    _monthYearController.addListener(_updateCardPreview);
  }


  @override
  void dispose() {
    _nameOnCardController.dispose();
    _cardNumberController.dispose();
    _monthYearController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _updateCardPreview() {
    setState(() {
      String rawNumber = _cardNumberController.text.replaceAll(' ', '');
      if (rawNumber.length > 12) {
        _displayCardNumber = 'XXXX XXXX XXXX ${rawNumber.substring(rawNumber.length - 4)}';
      } else {
        _displayCardNumber = rawNumber.padRight(16, 'X').replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} ').trim();
      }

      _displayCardHolderName = _nameOnCardController.text.isNotEmpty
          ? _nameOnCardController.text.toUpperCase()
          : 'CARD HOLDER NAME';

      _displayExpiryDate = _monthYearController.text.isNotEmpty
          ? _monthYearController.text
          : 'MM/YY';

    });
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
          'Add Credit Card',
          style: theme.textTheme.headlineMedium?.copyWith(fontSize: appWidth(5), color: theme.appBarTheme.foregroundColor),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.appBarTheme.foregroundColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: appWidth(5), vertical: appHeight(2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CreditCardPreviewWidget(
              cardNumber: _displayCardNumber,
              cardHolderName: _displayCardHolderName,
              expiryDate: _displayExpiryDate,
            ),
            SizedBox(height: appHeight(3)),

            Text(
              'Card Details',
              style: theme.textTheme.headlineMedium?.copyWith(fontSize: appWidth(4.5)),
            ),
            SizedBox(height: appHeight(2)),

            MyTextField(
              controller: _nameOnCardController,
              texts: 'Name on the card',
              icon: Icon(Icons.person_outline, color: theme.hintColor, size: appWidth(5)),
              keyboardType: TextInputType.name,
              decoration: _buildInputDecoration(context, hintText: 'Name on the card', prefixIcon: Icons.person_outline),
            ),
            SizedBox(height: appHeight(1.5)),

            MyTextField(
              controller: _cardNumberController,
              texts: 'Card number',
              icon: Icon(Icons.credit_card_outlined, color: theme.hintColor, size: appWidth(5)),
              keyboardType: TextInputType.number,
              maxLines: 19,
              decoration: _buildInputDecoration(context, hintText: 'Card number', prefixIcon: Icons.credit_card_outlined),
            ),
            SizedBox(height: appHeight(1.5)),

            Row(
              children: [
                Expanded(
                  child: MyTextField(
                    controller: _monthYearController,
                    texts: 'Month / Year',
                    icon: Icon(Icons.calendar_today_outlined, color: theme.hintColor, size: appWidth(5)),
                    keyboardType: TextInputType.datetime,
                    maxLines: 5,
                    decoration: _buildInputDecoration(context, hintText: 'Month / Year', prefixIcon: Icons.calendar_today_outlined),
                  ),
                ),
                SizedBox(width: appWidth(4)),
                Expanded(
                  child: MyTextField(
                    controller: _cvvController,
                    texts: 'CVV',
                    icon: Icon(Icons.lock_outline, color: theme.hintColor, size: appWidth(5)),
                    keyboardType: TextInputType.number,
                    maxLines: 3,
                    decoration: _buildInputDecoration(context, hintText: 'CVV', prefixIcon: Icons.lock_outline),
                  ),
                ),
              ],
            ),
            SizedBox(height: appHeight(2)),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Save this card',
                  style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: appWidth(4)),
                ),
                Switch(
                  value: _saveCard,
                  onChanged: (bool newValue) {
                    setState(() {
                      _saveCard = newValue;
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
                text: 'Add credit card',
                onPressed: () {
                  print('Add credit card tapped');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
