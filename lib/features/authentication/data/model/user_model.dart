import 'package:groceries/features/authentication/domain/entities/user_entites.dart';

class UserModel extends UserEntities {
  UserModel({
    required super.id,
    required super.first_name,
    required super.last_name,
    required super.email,
    super.profile_picture,
    required super.email_verified_at,
    required super.google_id,
    required super.created_at,
    required super.updated_at,
    super.phone
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      email: json['email'],
      profile_picture: json['profile_picture'],
      email_verified_at: json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'])
          : null,
      google_id: json['google_id'],
      created_at: DateTime.parse(json['created_at']),
      updated_at: DateTime.parse(json['updated_at']),
      phone: json["phone"]
    );
  }

}
