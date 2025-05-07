import 'package:groceries/features/authentication/domain/entities/user_entites.dart';

class ApiResponse{
  String message;
  UserEntities? userEntities;
  String? error;
  ApiResponse({required this.message, this.userEntities, this.error});
}