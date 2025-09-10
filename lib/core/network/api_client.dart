import 'package:dio/dio.dart';
import 'package:dio_jwt_demo/core/util/api_constants.dart';

class ApiClient {
  final Dio _dio;

  ApiClient({required Dio dio})
    : _dio = dio {
    // Logging interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options,handler){
          print("➡️ [REQUEST]");
          print("BaseUrl: ${options.baseUrl}");
          print("URL: ${options.baseUrl}${options.path}");
          print("Headers: ${options.headers}");
          print("Data: ${options.data}");
          return handler.next(options);
        },
        onResponse: (response,handler){
          print("✅ [RESPONSE]");
          print("Status: ${response.statusCode}");
          print("Data: ${response.data}");
          return handler.next(response);
    },
        onError: (DioException e, handler){
          print("❌ [ERROR]");
          print("ErrorMessage: ${e.error.toString()}");
          print("BaseUrl: ${e.requestOptions.baseUrl}");
          print("URL: ${e.requestOptions.baseUrl}${e.requestOptions.path}");
          print("Data: ${e.requestOptions.data}");
          print("Status: ${e.response?.statusCode}");
          print("Response: ${e.response?.data}");
          return handler.next(e);
        },
      ),
    );
  }
// Set JWT token in headers
void setJwt(String token){
  _dio.options.headers['Authorization'] = 'Bearer $token';
}
// Remove JWT token
void removeJwt(){
  _dio.options.headers.remove('Authorization');
}
// post request
Future<Response> post(String path, {dynamic data, Map<String,dynamic>? queryParameters}){
  return _dio.post(path,data: data,queryParameters: queryParameters);
}
Future<Response> get(String path, {Map<String,dynamic>? queryParameters}){
  return _dio.get(path,queryParameters: queryParameters);
}
}
