import 'package:groceries/features/authentication/data/model/api_response_model.dart';
import 'package:groceries/features/authentication/domain/entities/api_response.dart';

abstract class AuthRemoteDataSource {
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
    required device_name,
  });

  Future<ApiResponse> logout();


  Future<ApiResponse> user();

}
