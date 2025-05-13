import 'package:flutter/material.dart';

import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/features/authentication/presentation/widgets/button_widget.dart';
import 'package:groceries/features/profile/presentation/widget/address_widget.dart' show AddressCardWidget;
import 'package:groceries/features/profile/presentation/widget/build_dropdown.dart' show buildDropdownField;
import 'package:groceries/features/profile/presentation/widget/build_textfield.dart';



class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isDefault = false;
  String? _selectedCountry;


  final List<Map<String, dynamic>> addresses = [
    {
      'name': 'Russell Austin',
      'address': '2811 Crescent Day, LA Port\nCalifornia, United States 77571',
      'phoneNumber': '+1 202 555 0142',
      'isDefault': true,
    },
    {
      'name': 'Jissca Simpson',
      'address': '2811 Crescent Day, LA Port\nCalifornia, United States 77571',
      'phoneNumber': '+1 202 555 0142',
      'isDefault': false,
    },

  ];


  final List<String> _countries = ['United States', 'Canada', 'Mexico', 'Uzbekistan'];

  @override
  void dispose() {

    _nameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _zipCodeController.dispose();
    _countryController.dispose();
    _phoneController.dispose();
    super.dispose();
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
          'My Address',
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

              print('Add new address tapped');
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
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];
                return AddressCardWidget(
                  name: address['name'],
                  address: address['address'],
                  phoneNumber: address['phoneNumber'],
                  isDefault: address['isDefault'],
                  onEdit: () {
                    print('Edit address: ${address['name']}');
                  },
                );
              },
            ),
            SizedBox(height: appHeight(3)),


            Text(
              'Add New Address',
              style: theme.textTheme.headlineMedium?.copyWith(fontSize: appWidth(4.5)),
            ),
            SizedBox(height: appHeight(2)),

            buildTextField(
              context,
              controller: _nameController,
              hintText: 'Name',
              prefixIcon: Icons.person_outline,
            ),
            SizedBox(height: appHeight(1.5)),

            buildTextField(
              context,
              controller: _addressController,
              hintText: 'Address',
              prefixIcon: Icons.location_on_outlined,
              maxLines: 2,
            ),
            SizedBox(height: appHeight(1.5)),


            Row(
              children: [
                Expanded(
                  child: buildTextField(
                    context,
                    controller: _cityController,
                    hintText: 'City',
                    prefixIcon: Icons.location_city_outlined,
                  ),
                ),
                SizedBox(width: appWidth(4)),
                Expanded(
                  child: buildTextField(
                    context,
                    controller: _zipCodeController,
                    hintText: 'Zip code',
                    prefixIcon: Icons.markunread_mailbox_outlined,
                  ),
                ),
              ],
            ),
            SizedBox(height: appHeight(1.5)),


            buildDropdownField(
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
            SizedBox(height: appHeight(1.5)),

            buildTextField(
              context,
              controller: _phoneController,
              hintText: 'Phone number',
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
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
