class UserEntities {
  int id;
  String first_name;
  String last_name;
  String email;
  String? profile_picture;
  DateTime email_verified_at;
  String google_id;
  DateTime created_at;
  DateTime updated_at;

  UserEntities({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.email,
    this.profile_picture,
    required this.email_verified_at,
    required this.google_id,
    required this.created_at,
    required this.updated_at,
  });
}
