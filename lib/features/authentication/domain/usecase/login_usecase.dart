import 'package:groceries/features/authentication/domain/entities/api_response.dart';
import 'package:groceries/features/authentication/domain/repository/authRepository.dart';

class LoginUseCase {
  AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<ApiResponse> call({
    required String email,
    required String password,
    device_name,
  }) async {
    return authRepository.login(
      email: email,
      password: password,
      device_name: device_name,
    );
  }
}
