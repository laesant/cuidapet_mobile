import 'package:cuidapet_mobile/app/modules/auth/auth_module.dart';
import 'package:cuidapet_mobile/app/modules/auth/login/login_controller.dart';
import 'package:cuidapet_mobile/app/modules/auth/login/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  @override
  List<Module> get imports => [AuthModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton(LoginController.new);
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_) => const LoginPage());
    super.routes(r);
  }
}
