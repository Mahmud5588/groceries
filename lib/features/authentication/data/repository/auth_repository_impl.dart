import 'package:groceries/features/authentication/data/datasource/auth_local_datasource.dart';
import 'package:groceries/features/authentication/domain/entities/api_response.dart';
import 'package:groceries/features/authentication/domain/repository/authRepository.dart';
import 'package:groceries/features/authentication/data/model/user_credentials_model.dart';
import '../datasource/auth_remote_datasource.dart'; // AuthRemoteDataSourceImp endi ApiResponseModel qaytaradi

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDatasource _authLocalDatasource;

  AuthRepositoryImpl(this._authRemoteDataSource, this._authLocalDatasource);

  @override
  Future<ApiResponse> login({
    required String email,
    required String password,
    device_name,
  }) async {
    try {
      final apiResponse = await _authRemoteDataSource.login(
        email: email,
        password: password,
        device_name: device_name,
      );

      // ApiResponseModel da 'token' maydoni bo'lgani uchun, to'g'ridan-to'g'ri unga murojaat qilamiz
      if (apiResponse.token != null && apiResponse.token!.isNotEmpty) {
        await _authLocalDatasource.saveCredentials(
          UserCredentialsModel(email: email, password: password, token: apiResponse.token!),
        );
      } else {
        // Agar login muvaffaqiyatli bo'lsa-yu, lekin token qaytmasa (kamdan-kam holat)
        await _authLocalDatasource.saveCredentials(
          UserCredentialsModel(email: email, password: password, token: null),
        );
      }

      return apiResponse;
    } catch (e) {
      print('Login error: $e'); // Logger ishlatish afzalroq
      rethrow;
    }
  }

  @override
  Future<ApiResponse> logout() async {
    try {
      final apiResponse = await _authRemoteDataSource.logout();
      await _authLocalDatasource.deleteCredentials();
      return apiResponse;
    } catch (e) {
      print('Logout error: $e'); // Logger ishlatish afzalroq
      rethrow;
    }
  }

  @override
  Future<ApiResponse> register({
    required String first_name,
    String? last_name,
    required String email,
    required String password,
    required String password_confirmation,
    String? profile_picture,
  }) async {

    return _authRemoteDataSource.register(
      first_name: first_name,
      email: email,
      password: password,
      password_confirmation: password_confirmation,
      last_name: last_name,
      profile_picture: profile_picture,
    );
  }

  @override
  Future<ApiResponse> user() {
    return _authRemoteDataSource.user();
  }


}