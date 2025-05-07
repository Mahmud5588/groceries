import 'package:dio/dio.dart';
import 'package:groceries/core/network/urls.dart';

class DioClient{
  final Dio _dio;
  DioClient(this._dio){
    _dio.options.baseUrl=Urls.baseUrl;
    _dio.options.connectTimeout=const Duration(seconds: 30);
    _dio.options.receiveTimeout=const Duration(seconds: 30);
    _dio.options.sendTimeout=const Duration(seconds: 30);
    _dio.options.headers={
      'Content-Type':'application/json',
      'Accept':'application/json',
    };
    _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true
    ));
  }
  Future<Response> get(String path,{Map<String,dynamic>?queryParams} )async{
    return await _dio.get(path,queryParameters: queryParams);
  }
  Future<Response> post(String path,{dynamic data})async{
    return await _dio.post(path,data: data);
  }
  Future<Response> put(String path,{dynamic data})async{
    return await _dio.put(path,data: data);
  }
  Future<Response> delete(String path,{dynamic data})async{
    return await _dio.delete(path,data: data);

  }

}