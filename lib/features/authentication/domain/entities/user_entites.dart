class UserEntities {
  final int id;
  final String first_name;
  final String? last_name;
  final String email;
  final String? profile_picture;
  final DateTime? email_verified_at;
  final String? google_id;
  final DateTime created_at;
  final DateTime updated_at;
  final String? phone;

  UserEntities({
    required this.id,
    required this.first_name,
    this.last_name,
    required this.email,
    this.profile_picture,
    this.email_verified_at,
    this.google_id,
    required this.created_at,
    required this.updated_at,
    this.phone
  });
}
