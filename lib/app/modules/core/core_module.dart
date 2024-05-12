import 'package:cuidapet_mobile/app/core/rest_cliente/dio/dio_rest_client.dart';
import 'package:cuidapet_mobile/app/core/rest_cliente/rest_client.dart';
import 'package:cuidapet_mobile/app/modules/core/auth/auth_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addLazySingleton(AuthStore.new);
    i.addLazySingleton<RestClient>(DioRestClient.new);
    super.exportedBinds(i);
  }
}
