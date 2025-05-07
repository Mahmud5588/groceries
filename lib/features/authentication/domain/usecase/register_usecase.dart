import 'package:groceries/features/authentication/domain/entities/api_response.dart';
import 'package:groceries/features/authentication/domain/repository/authRepository.dart';

class RegisterUseCase {
  AuthRepository authRepository;

  RegisterUseCase({required this.authRepository});

  Future<ApiResponse> call({
    required String first_name,
    String? last_name,
    required String email,
    required String password,
    required String password_confirmation,
    String? profile_picture,
  }) async {
    return authRepository.register(
      first_name: first_name,
      email: email,
      password: password,
      password_confirmation: password_confirmation,
    );
  }
}
