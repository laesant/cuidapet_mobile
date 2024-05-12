import 'dart:async';

import 'package:cuidapet_mobile/app/core/helpers/constants.dart';
import 'package:cuidapet_mobile/app/core/helpers/environments.dart';
import 'package:cuidapet_mobile/app/core/rest_cliente/rest_client_exception.dart';
import 'package:dio/dio.dart';

import 'package:cuidapet_mobile/app/core/rest_cliente/rest_client.dart';
import 'package:cuidapet_mobile/app/core/rest_cliente/rest_client_response.dart';

class DioRestClient implements RestClient {
  late final Dio _dio;
  final _defaultOptions = BaseOptions(
    baseUrl: Environments.param(Constants.envBaseUrlKey) ?? '',
    connectTimeout: Duration(
        milliseconds: int.parse(
            Environments.param(Constants.envRestClientConnectTimeout) ?? '0')),
    receiveTimeout: Duration(
        milliseconds: int.parse(
            Environments.param(Constants.envRestClientReceiveTimeout) ?? '0')),
  );
  DioRestClient({
    BaseOptions? options,
  }) {
    _dio = Dio(options ?? _defaultOptions);
  }
  @override
  RestClient auth() {
    _defaultOptions.extra['auth_required'] = true;
    return this;
  }

  @override
  RestClient unauth() {
    _defaultOptions.extra['auth_required'] = false;
    return this;
  }

  @override
  Future<RestClientResponse<T>> delete<T>(String path,
      {data,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter(response);
    } on DioException catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> get<T>(String path,
      {Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter(response);
    } on DioException catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> patch<T>(String path,
      {data,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter(response);
    } on DioException catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> post<T>(String path,
      {data,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter(response);
    } on DioException catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> put<T>(String path,
      {data,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter(response);
    } on DioException catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> request<T>(String path,
      {required String method,
      data,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers, method: method),
      );

      return _dioResponseConverter(response);
    } on DioException catch (e) {
      _throwRestClientException(e);
    }
  }

  Future<RestClientResponse<T>> _dioResponseConverter<T>(
      Response<dynamic> response) async {
    return RestClientResponse<T>(
      data: response.data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }

  Never _throwRestClientException(DioException exception) {
    final response = exception.response;
    throw RestClientException(
        error: exception.error,
        message: response?.statusMessage,
        statusCode: response?.statusCode,
        response: RestClientResponse(
          data: response?.data,
          statusCode: response?.statusCode,
          statusMessage: response?.statusMessage,
        ));
  }
}
