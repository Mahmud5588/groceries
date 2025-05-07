import 'package:groceries/features/authentication/domain/entities/api_response.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  ApiResponse apiResponse;

  RegisterSuccess(this.apiResponse);
}

class RegisterFailure extends RegisterState {
  String error;

  RegisterFailure(this.error);
}
