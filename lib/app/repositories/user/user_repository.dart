import 'package:cuidapet_mobile/app/models/confirm_login.dart';

abstract interface class UserRepository {
  Future<void> register(String email, String password);
  Future<String> login(String email, String password);
  Future<ConfirmLogin> confirmLogin();
}
