import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/repositories/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './user_service.dart';

class UserServiceImpl implements UserService {
  final AppLogger _log;
  final UserRepository _userRepository;
  UserServiceImpl({
    required AppLogger log,
    required UserRepository userRepository,
  })  : _log = log,
        _userRepository = userRepository;
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
}
