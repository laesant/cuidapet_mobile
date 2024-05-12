import 'package:cuidapet_mobile/app/core/rest_cliente/rest_client_response.dart';

abstract interface class RestClient {
  RestClient auth();
  RestClient unauth();

  Future<RestClientResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  });

  Future<RestClientResponse<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  });

  Future<RestClientResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  });

  Future<RestClientResponse<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  });

  Future<RestClientResponse<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  });

  Future<RestClientResponse<T>> request<T>(
    String path, {
    required String method,
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  });
}
