import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/core/route/route_names.dart';
import 'package:groceries/features/authentication/presentation/widgets/button_widget.dart';
import 'package:groceries/features/profile/presentation/widget/credit_card_widget.dart' show CreditCardWidget;

class MyCardsPage extends StatefulWidget {
  const MyCardsPage({Key? key}) : super(key: key);

  @override
  State<MyCardsPage> createState() => _MyCardsPageState();
}

class _MyCardsPageState extends State<MyCardsPage> {
  // Form controllerlar
  final TextEditingController _nameOnCardController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  bool _isDefault = false; // "Make default" switch holati

  // Sample card data (misol uchun)
  final List<Map<String, dynamic>> cards = [
    {
      'cardType': 'Master Card',
      'lastFourDigits': '5678',
      'expiryDate': '01/22',
      'cvv': '908',
      'cardIconPath': 'assets/images/mastercard.png', // O\'zingizning ikonka yo\'lingizni qo\'ying
      'iconBackgroundColor': const Color(0xffFFE9E5), // Misol rang
      'isDefault': true,
    },
    {
      'cardType': 'Visa Card',
      'lastFourDigits': '5678',
      'expiryDate': '01/22',
      'cvv': '908',
      'cardIconPath': 'assets/images/mastercard.png', // O\'zingizning ikonka yo\'lingizni qo\'ying
      'iconBackgroundColor': const Color(0xffE5F7FF), // Misol rang
      'isDefault': false,
    },
    {
      'cardType': 'Master Card',
      'lastFourDigits': '5678',
      'expiryDate': '01/22',
      'cvv': '908',
      'cardIconPath': 'assets/images/mastercard.png', // O\'zingizning ikonka yo\'lingizni qo\'ying
      'iconBackgroundColor': const Color(0xffFFE9E5), // Misol rang
      'isDefault': false,
    },
    // Add more cards here
  ];

  @override
  void dispose() {
    // Controllerlarni dispose qilish
    _nameOnCardController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundPink, // Fon rangi
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPink,
        elevation: 0,
        title: Text(
          'My Cards',
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
            icon: const Icon(Icons.add_circle_outline, color: AppColors.textBlack), // Plus ikonasi
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.addCreditCardPage);
            },
          ),
        ],
      ),
      body: SingleChildScrollView( // Kontent sig'masa scroll qilish uchun
        padding: EdgeInsets.symmetric(horizontal: appWidth(5), vertical: appHeight(2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Karta kartalarini chiqarish
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
                    // Kartani tahrirlash funksiyasi
                    print('Edit card: ${card['cardType']}');
                  },
                );
              },
            ),
            SizedBox(height: appHeight(3)), // Kartalar va forma orasidagi bo'shliq

            // Karta kiritish formasi qismi
            Text(
              'Add New Card', // Forma sarlavhasi
              style: AppTextStyle.heading.copyWith(fontSize: appWidth(4.5)),
            ),
            SizedBox(height: appHeight(2)),

            // Name on Card Input
            _buildTextField(
              controller: _nameOnCardController,
              hintText: 'Russell Austin', // Misol matn
              prefixIcon: Icons.person_outline,
            ),
            SizedBox(height: appHeight(1.5)),

            // Card Number Input
            _buildTextField(
              controller: _cardNumberController,
              hintText: 'XXXX XXXX XXXX 5678', // Misol matn
              prefixIcon: Icons.credit_card_outlined,
              keyboardType: TextInputType.number, // Raqam kiritish uchun
            ),
            SizedBox(height: appHeight(1.5)),

            // Expiry Date and CVV Row
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _expiryDateController,
                    hintText: '01/22', // Misol matn
                    prefixIcon: Icons.calendar_today_outlined,
                    keyboardType: TextInputType.datetime, // Sana kiritish uchun
                  ),
                ),
                SizedBox(width: appWidth(4)),
                Expanded(
                  child: _buildTextField(
                    controller: _cvvController,
                    hintText: '908', // Misol matn
                    prefixIcon: Icons.lock_outline, // Qulf ikonasi
                    keyboardType: TextInputType.number, // Raqam kiritish uchun
                    maxLength: 3, // CVV odatda 3 raqamli bo'ladi
                  ),
                ),
              ],
            ),
            SizedBox(height: appHeight(2)),

            // Make Default Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Make default',
                  style: AppTextStyle.body.copyWith(fontWeight: FontWeight.bold, fontSize: appWidth(4)),
                ),
                Switch(
                  value: _isDefault,
                  onChanged: (bool newValue) {
                    setState(() {
                      _isDefault = newValue;
                    });
                  },
                  activeColor: AppColors.primaryDark,
                  inactiveTrackColor: AppColors.textGrey.withOpacity(0.3),
                ),
              ],
            ),
            SizedBox(height: appHeight(4)),

            // Save Settings Button
            SizedBox(
              width: double.infinity,
              height: appHeight(7),
              child: ButtonWidget(
                text: 'Save settings',
                onPressed: () {
                  // Sozlamalarni saqlash logikasi
                  print('Save settings tapped');
                  // Formadagi datalarni olish:
                  // print('Name on Card: ${_nameOnCardController.text}');
                  // print('Card Number: ${_cardNumberController.text}');
                  // print('Expiry Date: ${_expiryDateController.text}');
                  // print('CVV: ${_cvvController.text}');
                  // print('Is Default: $_isDefault');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable TextField widget (avvalgisidan olindi)
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    int? maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength, // Yangi: max belgilar soni uchun
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      maxLength: maxLength, // Max belgilar soni
      style: AppTextStyle.body.copyWith(fontSize: appWidth(3.5)),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyle.body.copyWith(color: AppColors.textGrey, fontSize: appWidth(3.5)),
        prefixIcon: Icon(prefixIcon, color: AppColors.textGrey, size: appWidth(5)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: AppColors.backgroundWhite,
        contentPadding: EdgeInsets.symmetric(vertical: appHeight(2), horizontal: appWidth(4)),
        counterText: "", // maxLength ishlatilganda pastdagi hisoblagichni yashirish
      ),
    );
  }
}