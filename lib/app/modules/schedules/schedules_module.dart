import 'package:cuidapet_mobile/app/modules/schedules/schedules_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SchedulesModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => const SchedulesPage(),
    );
    super.routes(r);
  }
}
