import 'package:groceries/features/authentication/domain/entities/api_response.dart';
import 'package:groceries/features/authentication/domain/entities/redirect_entities.dart';
import 'package:groceries/features/authentication/domain/repository/authRepository.dart';

import '../datasource/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<void> emailCallback({required String code, required String state}) {
    // TODO: implement emailCallback
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> emailResend() {
    // TODO: implement emailResend
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> emailVerify({
    required int id,
    required String token,
    required int expires,
    required String signature,
  }) {
    // TODO: implement emailVerify
    throw UnimplementedError();
  }

  @override
  Future<RedirectEntities> googleRedirect() {
    // TODO: implement googleRedirect
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> login({
    required String email,
    required String password,
     device_name,
  }) {
    return _authRemoteDataSource.login(
      email: email,
      password: password,
      device_name: device_name,
    );
  }

  @override
  Future<ApiResponse> logout() {
    return _authRemoteDataSource.logout();
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
    );
  }

  @override
  Future<ApiResponse> user() {
    return _authRemoteDataSource.user();
  }
}
