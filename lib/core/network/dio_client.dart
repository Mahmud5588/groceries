import 'package:dio/dio.dart';
import 'package:groceries/core/network/urls.dart';
import 'package:groceries/features/authentication/data/datasource/auth_local_datasource.dart';
import 'package:logger/logger.dart';

class DioClient {
  final Dio _dio;
  final AuthLocalDatasource _authLocalDatasource;
  final Logger _logger = Logger();

  DioClient(this._dio, this._authLocalDatasource) {
    _dio.options.baseUrl = Urls.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.sendTimeout = const Duration(seconds: 30);
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true
    ));

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          _logger.i('*** Request ***');
          _logger.i('uri: ${options.uri}');
          _logger.i('method: ${options.method}');
          _logger.i('headers: ${options.headers}');
          _logger.i('data: ${options.data}');

          final token = await _authLocalDatasource.getToken();

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          _logger.e('*** DioException ***');
          _logger.e('uri: ${e.requestOptions.uri}');
          _logger.e('DioException type: ${e.type}');
          _logger.e('DioException message: ${e.message}');
          if (e.response != null) {
            _logger.e('statusCode: ${e.response?.statusCode}');
            _logger.e('Response Text: ${e.response?.data}');
          }

          if (e.response?.statusCode == 401) {
            _logger.w('401 Unauthorized - Token expired or invalid. Clearing credentials.');
            await _authLocalDatasource.deleteCredentials();
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParams, Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(path, queryParameters: queryParams);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await _dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data}) async {
    return await _dio.put(path, data: data);
  }

  Future<Response> delete(String path, {dynamic data}) async {
    return await _dio.delete(path, data: data);
  }
}