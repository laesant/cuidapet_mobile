import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_not_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/helpers/constants.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/models/social_login_type.dart';
import 'package:cuidapet_mobile/app/models/social_network.dart';
import 'package:cuidapet_mobile/app/repositories/social/social_repository.dart';
import 'package:cuidapet_mobile/app/repositories/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './user_service.dart';

class UserServiceImpl implements UserService {
  final AppLogger _log;
  final UserRepository _userRepository;
  final SocialRepository _socialRepository;
  final LocalStorage _localStorage;
  final LocalSecureStorage _localSecureStorage;

  UserServiceImpl(
      {required AppLogger log,
      required UserRepository userRepository,
      required SocialRepository socialRepository,
      required LocalStorage localStorage,
      required LocalSecureStorage localSecureStorage})
      : _log = log,
        _userRepository = userRepository,
        _socialRepository = socialRepository,
        _localStorage = localStorage,
        _localSecureStorage = localSecureStorage;

  @override
  Future<void> register(String email, String password) async {
    try {
      final auth = FirebaseAuth.instance;
      await _userRepository.register(email, password);
      final UserCredential(:user) = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await user?.sendEmailVerification();
    } on FirebaseException catch (e, s) {
      _log.error('Erro ao criar usuario no firebase', e, s);
      throw Failure(message: 'Erro ao criar usuário');
    }
  }

  @override
  Future<void> login(String email, String password) async {
    try {
      final auth = FirebaseAuth.instance;

      final UserCredential(:user) = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (!(user?.emailVerified ?? false)) {
        user?.sendEmailVerification();
        throw Failure(
            message:
                'E-mail não confirmado, por favor verifique a sua caixa de spam.');
      }

      final accessToken = await _userRepository.login(email, password);
      await _saveAccessToken(accessToken);
      await _confirmLogin();
      await _getUserData();
    } on FirebaseAuthException catch (e, s) {
      _log.error(e.code, e, s);
      if (e.code == 'invalid-credential') {
        throw UserNotExistsException();
      }
    }
  }

  @override
  Future<void> socialLogin(SocialLoginType type) async {
    try {
      final SocialNetwork socialNetwork;
      final AuthCredential authCredential;
      final auth = FirebaseAuth.instance;

      switch (type) {
        case SocialLoginType.facebook:
          socialNetwork = await _socialRepository.facebookLogin();
          authCredential =
              FacebookAuthProvider.credential(socialNetwork.accessToken);
          break;
        case SocialLoginType.google:
          socialNetwork = await _socialRepository.googleLogin();
          authCredential = GoogleAuthProvider.credential(
            idToken: socialNetwork.id,
            accessToken: socialNetwork.accessToken,
          );
          break;
      }

      await auth.signInWithCredential(authCredential);
      final accessToken = await _userRepository.loginSocial(socialNetwork);
      await _saveAccessToken(accessToken);
      await _confirmLogin();
      await _getUserData();
    } on FirebaseAuthException catch (e, s) {
      _log.error('Erro ao realizar login com $type', e, s);
      throw Failure(message: 'Erro ao realizar login');
    }
  }

  Future<void> _saveAccessToken(String accessToken) => _localStorage
      .write<String>(Constants.localStorageAccessTokenKey, accessToken);

  Future<void> _confirmLogin() async {
    final confirmLogin = await _userRepository.confirmLogin();
    await _saveAccessToken(confirmLogin.accessToken);
    await _localSecureStorage.write(
        Constants.localStorageRefreshTokenKey, confirmLogin.refreshToken);
  }

  Future<void> _getUserData() async {
    final user = await _userRepository.getUserLogged();
    await _localStorage.write<String>(
        Constants.localStorageUserDataKey, user.toJson());
  }
}
