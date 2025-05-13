import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:groceries/core/const/colors/app_colors.dart';
import 'package:groceries/core/const/strings/text_styles.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/features/authentication/presentation/widgets/button_widget.dart';
import 'package:groceries/features/authentication/presentation/widgets/my_textfield.dart' show MyTextField;
class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  bool _saveAddress = false;
  String? _selectedCountry;

  final List<String> _countries = ['United States', 'Canada', 'Mexico', 'Uzbekistan'];


  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _zipCodeController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  InputDecoration _buildInputDecoration(BuildContext context, {
    required String hintText,
    required IconData prefixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).hintColor, fontSize: appWidth(3.5)),
      prefixIcon: Icon(prefixIcon, color: Theme.of(context).hintColor, size: appWidth(5)),
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
          'addAddress'.tr(),
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
            Text(
              'personalDetails'.tr(),
              style: theme.textTheme.headlineMedium?.copyWith(fontSize: appWidth(4.5)),
            ),
            SizedBox(height: appHeight(2)),

            MyTextField(
              controller: _nameController,
              texts: 'name'.tr(),
              icon: Icon(Icons.person_outline, color: theme.hintColor, size: appWidth(5)),
              keyboardType: TextInputType.name,
              decoration: _buildInputDecoration(context, hintText: 'name'.tr(), prefixIcon: Icons.person_outline),
            ),
            SizedBox(height: appHeight(1.5)),

            MyTextField(
              controller: _emailController,
              texts: 'Email address',
              icon: Icon(Icons.mail_outline, color: theme.hintColor, size: appWidth(5)),
              keyboardType: TextInputType.emailAddress,
              decoration: _buildInputDecoration(context, hintText: 'Email address', prefixIcon: Icons.mail_outline),
            ),
            SizedBox(height: appHeight(1.5)),

            MyTextField(
              controller: _phoneController,
              texts: 'Phone number',
              icon: Icon(Icons.phone_outlined, color: theme.hintColor, size: appWidth(5)),
              keyboardType: TextInputType.phone,
              decoration: _buildInputDecoration(context, hintText: 'Phone number', prefixIcon: Icons.phone_outlined),
            ),
            SizedBox(height: appHeight(1.5)),

            MyTextField(
              controller: _addressController,
              texts: 'Address',
              icon: Icon(Icons.location_on_outlined, color: theme.hintColor, size: appWidth(5)),
              maxLines: 2,
              decoration: _buildInputDecoration(context, hintText: 'Address', prefixIcon: Icons.location_on_outlined),
            ),
            SizedBox(height: appHeight(1.5)),

            MyTextField(
              controller: _zipCodeController,
              texts: 'Zip code',
              icon: Icon(Icons.markunread_mailbox_outlined, color: theme.hintColor, size: appWidth(5)),
              keyboardType: TextInputType.number,
              decoration: _buildInputDecoration(context, hintText: 'Zip code', prefixIcon: Icons.markunread_mailbox_outlined),
            ),
            SizedBox(height: appHeight(1.5)),

            MyTextField(
              controller: _cityController,
              texts: 'City',
              icon: Icon(Icons.location_city_outlined, color: theme.hintColor, size: appWidth(5)),
              decoration: _buildInputDecoration(context, hintText: 'City', prefixIcon: Icons.location_city_outlined),
            ),
            SizedBox(height: appHeight(1.5)),

            _buildDropdownField(
              context,
              hintText: 'Country',
              prefixIcon: Icons.language,
              value: _selectedCountry,
              items: _countries.map((String country) {
                return DropdownMenuItem<String>(
                  value: country,
                  child: Text(country, style: theme.textTheme.bodyMedium?.copyWith(fontSize: appWidth(3.5), color: theme.textTheme.bodyMedium?.color)),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCountry = newValue;
                });
              },
            ),
            SizedBox(height: appHeight(2)),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Save this address',
                  style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: appWidth(4)),
                ),
                Switch(
                  value: _saveAddress,
                  onChanged: (bool newValue) {
                    setState(() {
                      _saveAddress = newValue;
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

  Widget _buildDropdownField(BuildContext context, {
    required String hintText,
    required IconData prefixIcon,
    required String? value,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
  }) {
    final theme = Theme.of(context);
    return DropdownButtonFormField<String>(
      value: value,
      items: items,
      onChanged: onChanged,
      style: theme.textTheme.bodyMedium?.copyWith(fontSize: appWidth(3.5), color: theme.textTheme.bodyMedium?.color),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor, fontSize: appWidth(3.5)),
        prefixIcon: Icon(prefixIcon, color: theme.hintColor, size: appWidth(5)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: theme.cardColor,
        contentPadding: EdgeInsets.symmetric(vertical: appHeight(2), horizontal: appWidth(4)),
      ),
      icon: Icon(Icons.keyboard_arrow_down, color: theme.hintColor, size: appWidth(5)),
    );
  }
}
