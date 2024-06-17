import 'package:cuidapet_mobile/app/modules/address/address_detail/address_detail_module.dart';
import 'package:cuidapet_mobile/app/modules/address/address_page.dart';
import 'package:cuidapet_mobile/app/modules/address/widgets/address_search_widget/address_search_controller.dart';
import 'package:cuidapet_mobile/app/modules/core/core_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddressModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void binds(Injector i) {
    i.addLazySingleton(AddressSearchController.new);
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (_) => const AddressPage(),
    );
    r.module('/detail', module: AddressDetailModule());
    super.routes(r);
  }
}
