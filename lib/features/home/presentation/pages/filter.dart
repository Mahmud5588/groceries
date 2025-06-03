import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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

  // Mahsulot filtrlari
  bool _featuredSelected = false;
  bool _isNewSelected = false;
  bool _organicSelected = false;

  // Saralash filtrlari
  String? _selectedSortBy;
  String? _selectedSortOrder;

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

  void _resetFilters() {
    setState(() {
      _minPriceController.clear();
      _maxPriceController.clear();
      _featuredSelected = false;
      _isNewSelected = false;
      _organicSelected = false;
      _selectedSortBy = null;
      _selectedSortOrder = null;
    });
  }

  void _applyFilters() {
    final Map<String, dynamic> filters = {
      'minPrice': double.tryParse(_minPriceController.text),
      'maxPrice': double.tryParse(_maxPriceController.text),
      'featured': _featuredSelected,
      'isNew': _isNewSelected,
      'organic': _organicSelected,
      'sortBy': _selectedSortBy,
      'sortOrder': _selectedSortOrder,
    };
    filters.removeWhere((key, value) => value == null || (value is bool && !value));

    Navigator.pop(context, filters);
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
            onPressed: _resetFilters,
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
                    decoration: _buildInputDecoration(context, hintText: 'max'.tr()),
                  ),
                ),
              ],
            ),
            SizedBox(height: appHeight(4)),

            Text(
              'productAttributes'.tr(),
              style: theme.textTheme.headlineMedium?.copyWith(fontSize: appWidth(4.5)),
            ),
            SizedBox(height: appHeight(2)),
            FilterOptionWidget(
              icon: Icons.star_border,
              text: 'featuredProducts'.tr(),
              initialValue: _featuredSelected,
              onChanged: (newValue) {
                setState(() {
                  _featuredSelected = newValue;
                });
              },
            ),
            FilterOptionWidget(
              icon: Icons.new_releases_outlined,
              text: 'newProducts'.tr(),
              initialValue: _isNewSelected,
              onChanged: (newValue) {
                setState(() {
                  _isNewSelected = newValue;
                });
              },
            ),
            FilterOptionWidget(
              icon: Icons.eco_outlined,
              text: 'organicProducts'.tr(),
              initialValue: _organicSelected,
              onChanged: (newValue) {
                setState(() {
                  _organicSelected = newValue;
                });
              },
            ),
            SizedBox(height: appHeight(4)),

            Text(
              'sortBy'.tr(),
              style: theme.textTheme.headlineMedium?.copyWith(fontSize: appWidth(4.5)),
            ),
            SizedBox(height: appHeight(1)),
            Column(
              children: [
                RadioListTile<String>(
                  title: Text('name'.tr()),
                  value: 'name',
                  groupValue: _selectedSortBy,
                  onChanged: (value) {
                    setState(() {
                      _selectedSortBy = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('price'.tr()),
                  value: 'price',
                  groupValue: _selectedSortBy,
                  onChanged: (value) {
                    setState(() {
                      _selectedSortBy = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('created_at'.tr()),
                  value: 'created_at',
                  groupValue: _selectedSortBy,
                  onChanged: (value) {
                    setState(() {
                      _selectedSortBy = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: appHeight(2)),

            Text(
              'sortOrder'.tr(),
              style: theme.textTheme.headlineMedium?.copyWith(fontSize: appWidth(4.5)),
            ),
            SizedBox(height: appHeight(1)),
            Column(
              children: [
                RadioListTile<String>(
                  title: Text('asc'.tr()),
                  value: 'asc',
                  groupValue: _selectedSortOrder,
                  onChanged: (value) {
                    setState(() {
                      _selectedSortOrder = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('desc'.tr()),
                  value: 'desc',
                  groupValue: _selectedSortOrder,
                  onChanged: (value) {
                    setState(() {
                      _selectedSortOrder = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: appHeight(4)),

            SizedBox(
              width: double.infinity,
              height: appHeight(7),
              child: ButtonWidget(
                text: 'applyFilter'.tr(),
                onPressed: _applyFilters,
              ),
            ),
          ],
        ),
      ),
    );
  }
}