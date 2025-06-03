import 'dart:io';
import 'package:dio/dio.dart';
import 'package:groceries/core/network/dio_client.dart';
import 'package:groceries/core/network/urls.dart';
import 'package:groceries/features/authentication/data/datasource/auth_remote_datasource.dart';
import 'package:groceries/features/authentication/data/model/api_response_model.dart';
import 'package:groceries/features/authentication/domain/entities/api_response.dart'; // Bu import saqlanib qoladi
import 'package:logger/logger.dart';

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  final DioClient _dioClient;
  final Logger logger = Logger();

  AuthRemoteDataSourceImp(this._dioClient);

  Future<ApiResponseModel> _handleResponse(Future<Response> request) async {
    try {
      final response = await request;
      logger.i('Response data: ${response.data}');
      final statusCode = response.statusCode;

      if (statusCode == 200 || statusCode == 201) {
        return ApiResponseModel.fromJson(response.data);
      } else {
        // Xatolik holatida ham ApiResponseModel qaytaramiz
        return ApiResponseModel.fromJson(response.data);
      }
    } on DioException catch (dioError) {
      logger.e('Dio error: ${dioError.message}');
      String errorMessage = 'Kutilmagan xato ro\'y berdi. Iltimos, keyinroq urinib ko\'ring.';
      String? errorDetails;

      if (dioError.response != null && dioError.response!.data != null) {
        errorDetails = (dioError.response!.data is Map && dioError.response!.data.containsKey('message'))
            ? dioError.response!.data['message']
            : dioError.response!.toString();
      }

      if (dioError.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Ulanish vaqti tugadi. Internet aloqangizni tekshiring yoki keyinroq urinib ko\'ring.';
      } else if (dioError.type == DioExceptionType.sendTimeout) {
        errorMessage = 'Ma\'lumot yuborish vaqti tugadi. Internet aloqangizni tekshiring.';
      } else if (dioError.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'Javobni olish vaqti tugadi. Server bilan bog\'liq muammo bo\'lishi mumkin.';
      } else if (dioError.type == DioExceptionType.badResponse) {
        errorMessage = errorDetails ?? 'Serverdan xato javobi keldi: ${dioError.response?.statusCode}';
      } else if (dioError.type == DioExceptionType.cancel) {
        errorMessage = 'So\'rov bekor qilindi.';
      } else if (dioError.type == DioExceptionType.unknown) {
        if (dioError.error is SocketException) {
          errorMessage = 'Internet aloqasi mavjud emas. Iltimos, ulanishingizni tekshiring.';
        } else {
          errorMessage = 'Kutilmagan xato ro\'y berdi: ${dioError.message}';
        }
      }
      return ApiResponseModel(
        message: 'Error',
        error: errorMessage,
        userEntities: null,
        token: null,
        tokenType: null,
      );
    } on SocketException {
      logger.e('Internet aloqasi yo\'q.');
      return ApiResponseModel(message: 'Error', error: 'Internet aloqasi mavjud emas. Iltimos, ulanishingizni tekshiring.');
    } on FormatException {
      logger.e('Noto\'g\'ri javob formati.');
      return ApiResponseModel(message: 'Error', error: 'Serverdan noto\'g\'ri ma\'lumot qabul qilindi. Muammo bo\'lishi mumkin.');
    } catch (e) {
      logger.e('Kutilmagan xato: $e');
      return ApiResponseModel(message: 'Error', error: 'Kutilmagan xato ro\'y berdi. Iltimos, keyinroq urinib ko\'ring.');
    }
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