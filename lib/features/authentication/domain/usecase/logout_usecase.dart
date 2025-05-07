import 'package:groceries/features/authentication/domain/entities/api_response.dart';
import 'package:groceries/features/authentication/domain/repository/authRepository.dart';

class LogoutUseCase{
  AuthRepository authRepository;
  LogoutUseCase({required this.authRepository});
  Future<ApiResponse> call()async{
    return authRepository.logout();
  }

}