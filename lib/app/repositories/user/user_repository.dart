import 'package:cuidapet_mobile/app/models/confirm_login.dart';
import 'package:cuidapet_mobile/app/models/social_network.dart';
import 'package:cuidapet_mobile/app/models/user_model.dart';

abstract interface class UserRepository {
  Future<void> register(String email, String password);
  Future<String> login(String email, String password);
  Future<ConfirmLogin> confirmLogin();
  Future<UserModel> getUserLogged();
  Future<String> loginSocial(SocialNetwork socialNetwork);
}
