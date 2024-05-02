import 'package:cuidapet_mobile/app/modules/auth/auth_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    //  r.add(route)
    r.module('/auth', module: AuthModule());
    super.routes(r);
  }
}
