import 'package:groceries/features/authentication/domain/entities/api_response.dart';

abstract class AuthRepository {
  Future<ApiResponse> register({
    required String first_name,
    String? last_name,
    required String email,
    required String password,
    required String password_confirmation,
    String? profile_picture,
  });

  Future<ApiResponse> login({
    required String email,
    required String password,
     device_name,
  });

  Future<ApiResponse> logout();


  Future<ApiResponse> user();

}
