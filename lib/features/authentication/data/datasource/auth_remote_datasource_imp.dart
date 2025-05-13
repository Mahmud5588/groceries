import 'dart:io';
import 'package:dio/dio.dart';
import 'package:groceries/core/network/dio_client.dart';
import 'package:groceries/core/network/urls.dart';
import 'package:groceries/features/authentication/data/datasource/auth_remote_datasource.dart';
import 'package:groceries/features/authentication/data/model/api_response_model.dart';
import 'package:groceries/features/authentication/data/model/redirect.dart';
import 'package:groceries/features/authentication/domain/entities/api_response.dart';
import 'package:groceries/features/authentication/domain/entities/redirect_entities.dart';
import 'package:logger/logger.dart';

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  DioClient _dioClient;
  Logger logger = Logger();

  AuthRemoteDataSourceImp(this._dioClient);

  Future<ApiResponseModel> _handleResponse(Future<dynamic> request) async {
    try {
      final response = await request;
      logger.i('Response data: ${response.data}');
      final statusCode = response.statusCode;

      if (statusCode == 200 || statusCode == 201) {
        return ApiResponseModel.fromJson(response.data);
      } else if (statusCode == 400) {
        logger.w('Bad Request: $statusCode');
        return ApiResponseModel.fromJson(response.data);
      } else if (statusCode == 401) {
        logger.w('Unauthorized: $statusCode');
        return ApiResponseModel.fromJson(response.data);
      } else if (statusCode == 403) {
        logger.w('Forbidden: $statusCode');
        return ApiResponseModel.fromJson(response.data);
      } else if (statusCode == 404) {
        logger.w('Not Found: $statusCode');
        return ApiResponseModel.fromJson(response.data);
      } else if (statusCode == 422) {
        logger.w('Unprocessable Entity: $statusCode');
        return ApiResponseModel.fromJson(response.data);
      } else if (statusCode == 500) {
        logger.w('Internal Server Error: $statusCode');
        return ApiResponseModel.fromJson(response.data);
      } else {
        logger.w('Unexpected status code: $statusCode');
        return ApiResponseModel.fromJson(response.data);
      }
    } on DioException catch (dioError) {
      logger.e('Dio error: ${dioError.message}');
      if (dioError.response != null) {
        return ApiResponseModel.fromJson(dioError.response!.data);
      }
      throw Exception('Network error occurred: ${dioError.message}');
    } on SocketException catch (_) {
      logger.e('No Internet connection');
      throw Exception('No Internet connection');
    } on FormatException catch (_) {
      logger.e('Invalid response format');
      throw Exception('Invalid response format');
    } catch (e) {
      logger.e('Unexpected error: $e');
      throw Exception('Something went wrong');
    }
  }

  @override
  Future<void> emailCallback({
    required String code,
    required String state,
  }) async {
    // TODO: implement emailCallback
    throw UnimplementedError();
  }

  @override
  Future<ApiResponseModel> emailResend() {
    return _handleResponse(_dioClient.post(Urls.emailResend));
  }

  @override
  Future<ApiResponseModel> emailVerify({
    required int id,
    required String token,
    required int expires,
    required String signature,
  }) {
    // TODO: implement emailVerify
    throw UnimplementedError();
  }

  @override
  Future<RedirectModel> googleRedirect() {
    // TODO: implement googleRedirect
    throw UnimplementedError();
  }

  @override
  Future<ApiResponseModel> login({
    required String email,
    required String password,
    required device_name,
  }) {
    return _handleResponse(
      _dioClient.post(
        Urls.login,
        data: {
          'email': email,
          'password': password,
          'device_name': device_name,
        },
      ),
    );
  }

  @override
  Future<ApiResponseModel> logout() {
    return _handleResponse(_dioClient.post(Urls.logout));
  }

  @override
  Future<ApiResponseModel> register({
    required String first_name,
    String? last_name,
    required String email,
    required String password,
    required String password_confirmation,
    String? profile_picture,
  }) async {
    return _handleResponse(
      _dioClient.post(
        Urls.register,
        data: {
          'first_name': first_name,
          'last_name': last_name,
          'email': email,
          'password': password,
          'password_confirmation': password_confirmation,
          'profile_picture': profile_picture,
        },
      ),
    );
  }

  @override
  Future<ApiResponse> user() {
    return _handleResponse(_dioClient.get(Urls.user));
  }
}
