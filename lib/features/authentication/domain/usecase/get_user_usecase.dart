import 'package:groceries/features/authentication/domain/entities/api_response.dart';
import 'package:groceries/features/authentication/domain/repository/authRepository.dart';

class GetUserUseCase {
  AuthRepository authRepository;

  GetUserUseCase({required this.authRepository});

  Future<ApiResponse> call() async {
    return authRepository.user();
  }
}
