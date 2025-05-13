import 'package:hive/hive.dart';

part 'user_credentials_model.g.dart';

@HiveType(typeId: 0)
class UserCredentialsModel extends HiveObject {
  @HiveField(0)
  String email;
  @HiveField(1)
  String password;
  @HiveField(2)
  String token;

  UserCredentialsModel({
    required this.email,
    required this.password,
    required this.token,
  });
}
