import 'dart:io'; // File klassi uchun kerak
import 'package:equatable/equatable.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object?> get props => [];
}

class FetchUserProfile extends UserProfileEvent {}

class UpdateUserProfile extends UserProfileEvent {
  final String first_name;  // Ism (formadan har doim keladi deb taxmin qilinadi)
  final String? last_name;   // Familiya (ixtiyoriy bo'lishi mumkin)
  final String email;       // Email (formadan har doim keladi deb taxmin qilinadi)
  final String? phone;       // Telefon (ixtiyoriy bo'lishi mumkin)
  final String? currentPassword;
  final String? newPassword;
  final File? profileImageFile; // Tanlangan profil rasmi uchun fayl

  const UpdateUserProfile({
    required this.first_name,
    this.last_name, // Familiya endi ixtiyoriy
    required this.email,
    this.phone,     // Telefon endi ixtiyoriy
    this.currentPassword,
    this.newPassword,
    this.profileImageFile, // Rasm fayli qo'shildi
  });

  @override
  List<Object?> get props => [
    first_name,
    last_name,
    email,
    phone,
    currentPassword,
    newPassword,
    profileImageFile, // props ga qo'shildi
  ];
}