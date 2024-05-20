import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/rest_cliente/rest_client.dart';
import 'package:cuidapet_mobile/app/core/rest_cliente/rest_client_exception.dart';
import 'package:cuidapet_mobile/app/core/rest_cliente/rest_client_response.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient _restClient;
  final AppLogger _log;

  UserRepositoryImpl({required RestClient restClient, required AppLogger log})
      : _restClient = restClient,
        _log = log;
  @override
  Future<void> register(String email, String password) async {
    try {
      await _restClient.unauth().post('/auth/register', data: {
        'email': email,
        'password': password,
      });
    } on RestClientException catch (e, s) {
      if (e.statusCode == 400 &&
          e.response.data['message'].contains('Usuário já cadastrado')) {
        _log.error(e.error, e, s);
        throw UserExistsException();
      }

      _log.error('Erro ao cadastrar usuário', e, s);
      throw Failure(message: 'Erro ao registar usuário');
    }
  }

  @override
  Future<String> login(String email, String password) async {
    try {
      final RestClientResponse(:data) =
          await _restClient.unauth().post('/auth/', data: {
        'login': email,
        'password': password,
        'social_login': false,
        'supplier_user': false,
      });

      return data['access_token'];
    } on RestClientException catch (e, s) {
      _log.error('Erro ao realizar login', e, s);
      if (e.statusCode == 403) {
        throw Failure(
            message: 'Usuário inconsistente, entre em contato com o suporte.');
      }
      throw Failure(
          message: 'Erro ao realizar login, tente novamente mais tarde!');
    }
  }
}
