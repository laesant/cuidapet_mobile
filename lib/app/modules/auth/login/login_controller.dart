import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_not_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/loader.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/messsages.dart';
import 'package:cuidapet_mobile/app/models/social_login_type.dart';
import 'package:cuidapet_mobile/app/services/user/user_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  final UserService _userService;
  final AppLogger _log;

  LoginControllerBase(
      {required UserService userService, required AppLogger log})
      : _userService = userService,
        _log = log;

  Future<void> login(String email, String password) async {
    try {
      Loader.show();
      await _userService.login(email, password);
      Modular.to.navigate('/auth/');
    } on Failure catch (e, s) {
      const errorMsg = 'Erro ao realizar login';
      _log.error(e.message ?? errorMsg, e, s);
      Messages.alert(e.message ?? errorMsg);
    } on UserNotExistsException catch (e, s) {
      const errorMsg = 'E-mail ou senha incorretos!';
      _log.error(errorMsg, e, s);
      Messages.alert(errorMsg);
    } finally {
      Loader.hide();
    }
  }

  Future<void> socialLogin(SocialLoginType type) async {
    try {
      Loader.show();
      await _userService.socialLogin(type);
      Modular.to.navigate('/auth/');
    } on Failure catch (e, s) {
      _log.error('Erro ao fazer login', e, s);
      Messages.alert(e.message ?? 'Erro ao realizar login');
    } finally {
      Loader.hide();
    }
  }
}
