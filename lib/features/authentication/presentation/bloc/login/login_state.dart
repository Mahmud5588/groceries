import 'package:groceries/features/authentication/domain/entities/api_response.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  ApiResponse apiResponse;

  LoginSuccess(this.apiResponse);
}

class LoginFailure extends LoginState {
  String error;

  LoginFailure(this.error);
}
