import 'dart:developer' as developer;

import 'package:dio/dio.dart';

class APIService {
  APIService({Dio? dio}) : _dio = dio ?? Dio() {
    _dio.interceptors.add(
      LoggerInterceptor(
        request: !isProduction,
        response: !isProduction,
        error: !isProduction,
      ),
    );
  }

  final Dio _dio;
  bool isProduction = false;

  Future<Response<dynamic>> post(String endPoint, Map<String, dynamic> data) {
    return _dio.post(endPoint, data: data);
  }

  Future<Response<dynamic>> get(String endPoint, {Options? options}) {
    return _dio.get(endPoint, options: options);
  }

  void dispose() {
    _dio.close();
  }
}

class LoggerInterceptor extends Interceptor {
  LoggerInterceptor({
    this.request = true,
    this.response = true,
    this.error = true,
  });

  bool request;
  bool response;
  bool error;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (request) {
      developer.log('${options.method} ${options.uri}', name: 'APIService');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (this.response) {
      developer.log(
        '${response.statusCode} ${response.requestOptions.uri}',
        name: 'APIService',
      );
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (error) {
      developer.log(
        '${err.message} ${err.requestOptions.uri}',
        name: 'APIService',
      );
    }
    super.onError(err, handler);
  }
}
