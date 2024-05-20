import 'package:cuidapet_mobile/app/core/helpers/constants.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/modules/core/auth/auth_store.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final LocalStorage _localStorage;
  final AppLogger _log;
  final AuthStore _authStore;

  AuthInterceptor(
      {required LocalStorage localStorage,
      required AppLogger log,
      required AuthStore authStore})
      : _localStorage = localStorage,
        _log = log,
        _authStore = authStore;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final bool authRequired =
        options.extra[Constants.restClientAuthRequired] ?? false;

    if (authRequired) {
      final accessToken = await _localStorage
          .read<String>(Constants.localStorageAccessTokenKey);

      if (accessToken == null) {
        _authStore.logout();
        return handler.reject(DioException(
          requestOptions: options,
          error: 'Expire Token',
          type: DioExceptionType.cancel,
        ));
      }

      options.headers['Authorization'] = accessToken;
    } else {
      options.headers.remove('Authorization');
    }

    super.onRequest(options, handler);
  }
}
