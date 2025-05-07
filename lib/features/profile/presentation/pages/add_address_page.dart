import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/features/authentication/presentation/widgets/button_widget.dart';
import 'package:groceries/features/authentication/presentation/widgets/my_textfield.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  // Form controllerlar
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  bool _saveAddress = false; // "Save this address" switch holati
  String? _selectedCountry; // Tanlangan davlat

  // Sample country data (misol uchun)
  final List<String> _countries = ['United States', 'Canada', 'Mexico', 'Uzbekistan'];


  @override
  void dispose() {
    // Controllerlarni dispose qilish
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _zipCodeController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  // Kiritish maydonlari uchun umumiy InputDecoration stili
  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData prefixIcon,
    int? maxLines = 1, // Bu decoration ga emas, TextField ga tegishli, lekin bu yerda eslatma uchun
    TextInputType keyboardType = TextInputType.text, // Bu decoration ga emas, TextField ga tegishli
    int? maxLength, // Bu decoration ga emas, TextField ga tegishli
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: AppTextStyle.body.copyWith(color: AppColors.textGrey, fontSize: appWidth(3.5)),
      prefixIcon: Icon(prefixIcon, color: AppColors.textGrey, size: appWidth(5)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none, // Border chizig'ini olib tashlash
      ),
      enabledBorder: OutlineInputBorder( // enable holati uchun ham
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder( // focus holati uchun ham
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      filled: true, // Fonni to'ldirish
      fillColor: AppColors.backgroundWhite, // Fon rangi
      contentPadding: EdgeInsets.symmetric(vertical: appHeight(2), horizontal: appWidth(4)), // Ichki bo'shliq
      counterText: "", // maxLength ishlatilganda pastdagi hisoblagichni yashirish
    );
  }


  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context); // AppResponsive'ni boshlash

    return Scaffold(
      backgroundColor: AppColors.backgroundPink, // Fon rangi
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPink,
        elevation: 0,
        title: Text(
          'Add Address',
          style: AppTextStyle.heading.copyWith(fontSize: appWidth(5)),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textBlack),
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
            // Name Input - MyTextField yordamida
            MyTextField(
              controller: _nameController,
              texts: 'Name', // hintText o'rniga texts
              icon: Icon(Icons.person_outline, color: AppColors.textGrey, size: appWidth(5)), // icon o'rniga icon widgeti
              decoration: _buildInputDecoration(hintText: 'Name', prefixIcon: Icons.person_outline), // Decoration uzatish
            ),
            SizedBox(height: appHeight(1.5)),

            // Email Address Input - MyTextField yordamida
            MyTextField(
              controller: _emailController,
              texts: 'Email address',
              icon: Icon(Icons.mail_outline, color: AppColors.textGrey, size: appWidth(5)),
              keyboardType: TextInputType.emailAddress,
              decoration: _buildInputDecoration(hintText: 'Email address', prefixIcon: Icons.mail_outline),
            ),
            SizedBox(height: appHeight(1.5)),

            // Phone number Input - MyTextField yordamida
            MyTextField(
              controller: _phoneController,
              texts: 'Phone number',
              icon: Icon(Icons.phone_outlined, color: AppColors.textGrey, size: appWidth(5)),
              keyboardType: TextInputType.phone,
              decoration: _buildInputDecoration(hintText: 'Phone number', prefixIcon: Icons.phone_outlined),
            ),
            SizedBox(height: appHeight(1.5)),

            // Address Input - MyTextField yordamida
            MyTextField(
              controller: _addressController,
              texts: 'Address',
              icon: Icon(Icons.location_on_outlined, color: AppColors.textGrey, size: appWidth(5)),
              maxLines: 2,
              decoration: _buildInputDecoration(hintText: 'Address', prefixIcon: Icons.location_on_outlined),
            ),
            SizedBox(height: appHeight(1.5)),

            // Zip code Input - MyTextField yordamida
            MyTextField(
              controller: _zipCodeController,
              texts: 'Zip code',
              icon: Icon(Icons.markunread_mailbox_outlined, color: AppColors.textGrey, size: appWidth(5)),
              keyboardType: TextInputType.number,
              decoration: _buildInputDecoration(hintText: 'Zip code', prefixIcon: Icons.markunread_mailbox_outlined),
            ),
            SizedBox(height: appHeight(1.5)),

            // City Input - MyTextField yordamida
            MyTextField(
              controller: _cityController,
              texts: 'City',
              icon: Icon(Icons.location_city_outlined, color: AppColors.textGrey, size: appWidth(5)),
              decoration: _buildInputDecoration(hintText: 'City', prefixIcon: Icons.location_city_outlined),
            ),
            SizedBox(height: appHeight(1.5)),

            // Country Input (Dropdown) - O'zgarishsiz qoldi
            _buildDropdownField(
              hintText: 'Country',
              prefixIcon: Icons.language,
              value: _selectedCountry,
              items: _countries.map((String country) {
                return DropdownMenuItem<String>(
                  value: country,
                  child: Text(country, style: AppTextStyle.body.copyWith(fontSize: appWidth(3.5))),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCountry = newValue;
                });
              },
            ),
            SizedBox(height: appHeight(2)),

            // Save this address Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Save this address',
                  style: AppTextStyle.body.copyWith(fontWeight: FontWeight.bold, fontSize: appWidth(4)),
                ),
                Switch(
                  value: _saveAddress,
                  onChanged: (bool newValue) {
                    setState(() {
                      _saveAddress = newValue;
                    });
                  },
                  activeColor: AppColors.primaryDark,
                  inactiveTrackColor: AppColors.textGrey.withOpacity(0.3),
                ),
              ],
            ),
            SizedBox(height: appHeight(4)),

            // Add address Button
            SizedBox(
              width: double.infinity,
              height: appHeight(7),
              child: ButtonWidget(
                text: 'Add address',
                onPressed: () {
                  print('Add address tapped');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String hintText,
    required IconData prefixIcon,
    required String? value,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items,
      onChanged: onChanged,
      style: AppTextStyle.body.copyWith(fontSize: appWidth(3.5), color: AppColors.textBlack),
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
      ),
      icon: Icon(Icons.keyboard_arrow_down, color: AppColors.textGrey, size: appWidth(5)),
    );
  }
}