import 'package:groceries/features/authentication/domain/entities/api_response.dart';

abstract class LogoutState {}

class LogoutInitial extends LogoutState {}

class LogoutLoading extends LogoutState {}

class LogoutSuccess extends LogoutState {
  ApiResponse apiResponse;

  LogoutSuccess(this.apiResponse);
}

class LogoutFailure extends LogoutState {
  String error;

  LogoutFailure(this.error);
}
