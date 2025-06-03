import 'dart:io'; // File uchun
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/core/const/utils/app_responsive.dart';
import 'package:groceries/features/authentication/presentation/bloc/user/user_bloc.dart';
import 'package:groceries/features/authentication/presentation/bloc/user/user_event.dart';
import 'package:groceries/features/authentication/presentation/widgets/button_widget.dart';
import 'package:groceries/features/authentication/presentation/widgets/my_textfield.dart';
import 'package:image_picker/image_picker.dart'; // image_picker importi

import '../../../authentication/domain/entities/user_entites.dart';
import '../../../authentication/presentation/bloc/user/user_state.dart';

class AboutMePage extends StatefulWidget {
  const AboutMePage({Key? key}) : super(key: key);

  @override
  _AboutMePageState createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController(); // Telefon uchun
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  File? _selectedImageFile; // Tanlangan rasm fayli uchun

  @override
  void initState() {
    super.initState();
    // UserProfileBloc ning holatini tekshirish va ma'lumotlarni to'ldirish
    final currentState = context.read<UserProfileBloc>().state;
    if (currentState is UserProfileLoaded) {
      _populateFields(currentState.user);
    } else if (currentState is UserProfileInitial || currentState is UserProfileLoading && _firstNameController.text.isEmpty) {
      // Agar ma'lumotlar hali yuklanmagan bo'lsa, FetchUserProfile eventini yuborish
      context.read<UserProfileBloc>().add(FetchUserProfile());
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _populateFields(UserEntities user) {
    _firstNameController.text = user.first_name;
    _lastNameController.text = user.last_name ?? '';
    _emailController.text = user.email;
    // UserEntities da phone maydoni bor deb taxmin qilinadi,
    // agar yo'q bo'lsa, uni qo'shish yoki moslashtirish kerak.
    _phoneController.text = user.phone ?? ''; // `phone` maydoni UserEntities da bo'lishi kerak
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80, // Rasm sifatini pasaytirish (optional)
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Rasmni tanlashda xatolik: $e'.tr())),
      );
    }
  }

  InputDecoration _buildInputDecoration(BuildContext context, {
    required String hintText,
    required IconData prefixIcon,
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

  void _onSaveSettings() {
    if (_newPasswordController.text.isNotEmpty || _confirmPasswordController.text.isNotEmpty) {
      if (_newPasswordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('newPasswordsDoNotMatch'.tr())),
        );
        return;
      }
      if (_currentPasswordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('enterCurrentPassword'.tr())),
        );
        return;
      }
    }

    context.read<UserProfileBloc>().add(
      UpdateUserProfile(
        first_name: _firstNameController.text.trim(),
        last_name: _lastNameController.text.trim().isNotEmpty ? _lastNameController.text.trim() : null,
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim().isNotEmpty ? _phoneController.text.trim() : null,
        currentPassword: _currentPasswordController.text.isNotEmpty ? _currentPasswordController.text : null,
        newPassword: _newPasswordController.text.isNotEmpty ? _newPasswordController.text : null,
        profileImageFile: _selectedImageFile,
      ),
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
          'aboutMe'.tr(),
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
      body: BlocConsumer<UserProfileBloc, UserProfileState>(
        listener: (context, state) {
          if (state is UserProfileLoaded) {
            _populateFields(state.user);
          } else if (state is UserProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${'errorPrefix'.tr()}: ${state.message}'.tr())),
            );
          } else if (state is UserProfileUpdateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message.tr())),
            );
            _populateFields(state.props as UserEntities);
            setState(() {
              _selectedImageFile = null;
            });
          }
        },
        builder: (context, state) {
          UserEntities? currentUser;
          if (state is UserProfileLoaded) {
            currentUser = state.user;
          } else if (state is UserProfileUpdateSuccess) {
            currentUser = state.props as UserEntities?;
          }


          if (state is UserProfileLoading && _firstNameController.text.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          ImageProvider currentImageProvider = const AssetImage('assets/images/default_avatar.png'); // standart avatar
          if (_selectedImageFile != null) {
            currentImageProvider = FileImage(_selectedImageFile!);
          } else if (currentUser?.profile_picture != null && currentUser!.profile_picture!.isNotEmpty) {
            currentImageProvider = NetworkImage(currentUser.profile_picture!);
          }


          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: appWidth(5), vertical: appHeight(2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: appWidth(15),
                        backgroundImage: currentImageProvider,
                        backgroundColor: theme.dividerColor,
                      ),
                      Positioned(
                        right: appWidth(0),
                        bottom: appHeight(0),
                        child: InkWell(
                          onTap: _pickImage,
                          child: Container(
                            padding: EdgeInsets.all(appWidth(1.5)),
                            decoration: BoxDecoration(
                              color: theme.primaryColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: theme.scaffoldBackgroundColor, width: 2),
                            ),
                            child: Icon(
                              Icons.edit,
                              color: theme.colorScheme.onPrimary,
                              size: appWidth(5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: appHeight(3)),

                Text(
                  'personalDetails'.tr(),
                  style: theme.textTheme.headlineMedium?.copyWith(fontSize: appWidth(4.5)),
                ),
                SizedBox(height: appHeight(2)),

                MyTextField(
                  controller: _firstNameController,
                  texts: 'firstName'.tr(),
                  icon: Icon(Icons.person_outline, color: theme.hintColor, size: appWidth(5)),
                  keyboardType: TextInputType.name,
                  decoration: _buildInputDecoration(context, hintText: 'firstName'.tr(), prefixIcon: Icons.person_outline),
                ),
                SizedBox(height: appHeight(1.5)),

                MyTextField(
                  controller: _lastNameController,
                  texts: 'lastName'.tr(),
                  icon: Icon(Icons.person_outline, color: theme.hintColor, size: appWidth(5)),
                  keyboardType: TextInputType.name,
                  decoration: _buildInputDecoration(context, hintText: 'lastName'.tr(), prefixIcon: Icons.person_outline),
                ),
                SizedBox(height: appHeight(1.5)),

                MyTextField(
                  controller: _emailController,
                  texts: 'email'.tr(),
                  icon: Icon(Icons.mail_outline, color: theme.hintColor, size: appWidth(5)),
                  keyboardType: TextInputType.emailAddress,
                  decoration: _buildInputDecoration(context, hintText: 'email'.tr(), prefixIcon: Icons.mail_outline),
                ),
                SizedBox(height: appHeight(1.5)),

                MyTextField(
                  controller: _phoneController,
                  texts: 'phoneNumber'.tr(),
                  icon: Icon(Icons.phone_outlined, color: theme.hintColor, size: appWidth(5)),
                  keyboardType: TextInputType.phone,
                  decoration: _buildInputDecoration(context, hintText: 'phoneNumber'.tr(), prefixIcon: Icons.phone_outlined),
                ),
                SizedBox(height: appHeight(4)),

                Text(
                  'changePassword'.tr(),
                  style: theme.textTheme.headlineMedium?.copyWith(fontSize: appWidth(4.5)),
                ),
                SizedBox(height: appHeight(2)),

                MyTextField(
                  controller: _currentPasswordController,
                  texts: 'currentPassword'.tr(),
                  icon: Icon(Icons.lock_outline, color: theme.hintColor, size: appWidth(5)),
                  obscureText: _obscureCurrentPassword,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: _buildInputDecoration(context, hintText: 'currentPassword'.tr(), prefixIcon: Icons.lock_outline).copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureCurrentPassword ? Icons.visibility_off : Icons.visibility,
                        color: theme.hintColor,
                        size: appWidth(5),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureCurrentPassword = !_obscureCurrentPassword;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: appHeight(1.5)),

                MyTextField(
                  controller: _newPasswordController,
                  texts: 'newPassword'.tr(),
                  icon: Icon(Icons.lock_outline, color: theme.hintColor, size: appWidth(5)),
                  obscureText: _obscureNewPassword,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: _buildInputDecoration(context, hintText: 'newPassword'.tr(), prefixIcon: Icons.lock_outline).copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureNewPassword ? Icons.visibility_off : Icons.visibility,
                        color: theme.hintColor,
                        size: appWidth(5),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureNewPassword = !_obscureNewPassword;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: appHeight(1.5)),

                MyTextField(
                  controller: _confirmPasswordController,
                  texts: 'confirmPassword'.tr(),
                  icon: Icon(Icons.lock_outline, color: theme.hintColor, size: appWidth(5)),
                  obscureText: _obscureConfirmPassword,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: _buildInputDecoration(context, hintText: 'confirmPassword'.tr(), prefixIcon: Icons.lock_outline).copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                        color: theme.hintColor,
                        size: appWidth(5),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: appHeight(4)),

                if (state is UserProfileLoading && _firstNameController.text.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(bottom: appHeight(2)),
                    child: const Center(child: CircularProgressIndicator()),
                  ),

                SizedBox(
                  width: double.infinity,
                  height: appHeight(7),
                  child: ButtonWidget(
                    text: 'saveSettings'.tr(),
                    onPressed: (state is UserProfileLoading) ? null : _onSaveSettings,
                  ),
                ),
                SizedBox(height: appHeight(2)),
              ],
            ),
          );
        },
      ),
    );
  }
}