import 'package:groceries/features/authentication/data/model/user_model.dart';
import 'package:groceries/features/authentication/domain/entities/api_response.dart';

class ApiResponseModel extends ApiResponse {
  ApiResponseModel({required super.message, super.userEntities, super.error,super.token,super.tokenType});

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) {
    return ApiResponseModel(
      message: json['message'],
      userEntities:
          json['user'] != null ? UserModel.fromJson(json['user']) : null,
      error: json['error'],
      token: json['access_token'],
      tokenType: json['token_type'],
    );
  }
}
