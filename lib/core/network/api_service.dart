import 'package:dio/dio.dart';

class APIService {
  final Dio _dio = Dio();

  bool isProduction = false;

  APIService() {
    _dio.interceptors.add(
      LoggerInterceptor(request: !isProduction, response: !isProduction, error: !isProduction)
    );
  }

  Future<Response> post(String endPoint, Map<String, dynamic> data) => _dio.post(endPoint, data: data);

  Future<Response> get(String endPoint, {Options? options}) => _dio.get(endPoint, options: options);

}

class LoggerInterceptor extends Interceptor  {
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
      print('Request: ${options.method} ${options.path}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (this.response) {
      print('Response: ${response.statusCode} ${response.requestOptions.path}');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (error) {
      print('Error: ${err.message} ${err.requestOptions.path}');
    }
    super.onError(err, handler);
  }

}