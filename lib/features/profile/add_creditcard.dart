
import 'package:flutter/material.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/features/authentication/presentation/widgets/button_widget.dart';
import 'package:groceries/features/profile/presentation/widget/credit_card_preview.dart' show CreditCardPreviewWidget;

import '../../core/const/colors/app_colors.dart' show AppColors;

class AddCreditCardPage extends StatefulWidget {
  const AddCreditCardPage({Key? key}) : super(key: key);

  @override
  State<AddCreditCardPage> createState() => _AddCreditCardPageState();
}

class _AddCreditCardPageState extends State<AddCreditCardPage> {
  // Form controllerlar
  final TextEditingController _nameOnCardController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _monthYearController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  bool _saveCard = false; // "Save this card" switch holati

  // Karta preview uchun state
  String _displayCardNumber = 'XXXX XXXX XXXX XXXX';
  String _displayCardHolderName = 'CARD HOLDER NAME';
  String _displayExpiryDate = 'MM/YY';


  @override
  void initState() {
    super.initState();
    // Form maydonlaridagi o'zgarishlarni kuzatish va previewni yangilash
    _nameOnCardController.addListener(_updateCardPreview);
    _cardNumberController.addListener(_updateCardPreview);
    _monthYearController.addListener(_updateCardPreview);
  }


  @override
  void dispose() {
    // Controllerlarni dispose qilish
    _nameOnCardController.dispose();
    _cardNumberController.dispose();
    _monthYearController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _updateCardPreview() {
    setState(() {
      // Karta raqamini formatlash (faqat oxirgi 4 ta raqam yoki to'liq)
      String rawNumber = _cardNumberController.text.replaceAll(' ', '');
      if (rawNumber.length > 12) {
        _displayCardNumber = 'XXXX XXXX XXXX ${rawNumber.substring(rawNumber.length - 4)}';
      } else {
        _displayCardNumber = rawNumber.padRight(16, 'X').replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} ').trim();
      }


      // Karta egasi ismi (agar kiritilgan bo'lsa, katta harflarda)
      _displayCardHolderName = _nameOnCardController.text.isNotEmpty
          ? _nameOnCardController.text.toUpperCase()
          : 'CARD HOLDER NAME';

      // Tugash sanasi
      _displayExpiryDate = _monthYearController.text.isNotEmpty
          ? _monthYearController.text
          : 'MM/YY';

    });
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
          'Add Credit Card',
          style: AppTextStyle.heading.copyWith(fontSize: appWidth(5)),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textBlack),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // Rasmdagi appbar da qo'shimcha icon yo'q
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: appWidth(5), vertical: appHeight(2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Karta Preview qismi
            CreditCardPreviewWidget(
              cardNumber: _displayCardNumber,
              cardHolderName: _displayCardHolderName,
              expiryDate: _displayExpiryDate,
            ),
            SizedBox(height: appHeight(3)), // Preview va forma orasidagi bo'shliq

            // Karta kiritish formasi qismi
            Text(
              'Card Details', // Forma sarlavhasi (rasmda yo'q, lekin tushunarli bo'lishi uchun)
              style: AppTextStyle.heading.copyWith(fontSize: appWidth(4.5)),
            ),
            SizedBox(height: appHeight(2)),


            // Name on the card Input
            _buildTextField(
              controller: _nameOnCardController,
              hintText: 'Name on the card',
              prefixIcon: Icons.person_outline,
            ),
            SizedBox(height: appHeight(1.5)),

            // Card number Input
            _buildTextField(
              controller: _cardNumberController,
              hintText: 'Card number',
              prefixIcon: Icons.credit_card_outlined,
              keyboardType: TextInputType.number,
              maxLength: 19, // Odatda karta raqami 16-19 belgidan iborat (bo'shliqlarni hisobga olsak)
            ),
            SizedBox(height: appHeight(1.5)),

            // Month / Year and CVV Row
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _monthYearController,
                    hintText: 'Month / Year',
                    prefixIcon: Icons.calendar_today_outlined,
                    keyboardType: TextInputType.datetime,
                    maxLength: 5, // MM/YY formatida
                  ),
                ),
                SizedBox(width: appWidth(4)),
                Expanded(
                  child: _buildTextField(
                    controller: _cvvController,
                    hintText: 'CVV',
                    prefixIcon: Icons.lock_outline,
                    keyboardType: TextInputType.number,
                    maxLength: 3, // CVV odatda 3 raqamli
                  ),
                ),
              ],
            ),
            SizedBox(height: appHeight(2)),

            // Save this card Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Save this card',
                  style: AppTextStyle.body.copyWith(fontWeight: FontWeight.bold, fontSize: appWidth(4)),
                ),
                Switch(
                  value: _saveCard,
                  onChanged: (bool newValue) {
                    setState(() {
                      _saveCard = newValue;
                    });
                  },
                  activeColor: AppColors.primaryDark,
                  inactiveTrackColor: AppColors.textGrey.withOpacity(0.3),
                ),
              ],
            ),
            SizedBox(height: appHeight(4)),

            // Add credit card Button
            SizedBox(
              width: double.infinity,
              height: appHeight(7),
              child: ButtonWidget(
                text: 'Add credit card',
                onPressed: () {
                  // Karta qo'shish logikasi
                  print('Add credit card tapped');
                  // Formadagi datalarni olish:
                  // print('Name on Card: ${_nameOnCardController.text}');
                  // print('Card Number: ${_cardNumberController.text}');
                  // print('Month/Year: ${_monthYearController.text}');
                  // print('CVV: ${_cvvController.text}');
                  // print('Save Card: $_saveCard');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable TextField widget (oldin ishlatilgan va max belgilar soni uchun yangilangan)
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    int? maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      maxLength: maxLength,
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
        counterText: "",
      ),
    );
  }
}