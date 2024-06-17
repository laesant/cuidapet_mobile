import 'package:cuidapet_mobile/app/core/local_storage/flutter_secure_storage/flutter_secure_storage_local_storage_impl.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/core/local_storage/shared_preferences/shared_preferences_local_storage_impl.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger_impl.dart';
import 'package:cuidapet_mobile/app/core/rest_cliente/dio/dio_rest_client.dart';
import 'package:cuidapet_mobile/app/core/rest_cliente/rest_client.dart';
import 'package:cuidapet_mobile/app/modules/core/auth/auth_store.dart';
import 'package:cuidapet_mobile/app/repositories/address/address_repository.dart';
import 'package:cuidapet_mobile/app/repositories/address/address_repository_impl.dart';
import 'package:cuidapet_mobile/app/services/address/address_service.dart';
import 'package:cuidapet_mobile/app/services/address/address_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addLazySingleton<AppLogger>(AppLoggerImpl.new);
    i.addLazySingleton<LocalStorage>(SharedPreferencesLocalStorageImpl.new);
    i.addLazySingleton<LocalSecureStorage>(
        FlutterSecureStorageLocalStorageImpl.new);
    i.addLazySingleton(AuthStore.new);
    i.addLazySingleton<RestClient>(DioRestClient.new);
    i.addLazySingleton<AddressRepository>(AddressRepositoryImpl.new);
    i.addLazySingleton<AddressService>(AddressServiceImpl.new);
    super.exportedBinds(i);
  }
}
