abstract class AuthEvent {}

class RegisterEvent extends AuthEvent {
  final String first_name;
  final String? last_name;
  final String email;
  final String password;
  final String password_confirmation;
  final String? profile_picture;

  RegisterEvent({
    required this.first_name,
    this.last_name,
    required this.email,
    required this.password,
    required this.password_confirmation,
    this.profile_picture,
  });
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  final String? device_name;

  LoginEvent({
    required this.email,
    required this.password,
     this.device_name,
  });
}

class LogoutEvent extends AuthEvent {

}
