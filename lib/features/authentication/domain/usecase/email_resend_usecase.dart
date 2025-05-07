import 'package:groceries/features/authentication/domain/repository/authRepository.dart';

import '../entities/api_response.dart' show ApiResponse;

class EmailResendUseCase{
  AuthRepository authRepository;
  EmailResendUseCase({required this.authRepository});
  Future<ApiResponse> call()async{
    return authRepository.emailResend();
  }

}