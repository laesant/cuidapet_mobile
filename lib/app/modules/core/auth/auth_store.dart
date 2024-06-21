import 'package:cuidapet_mobile/app/core/helpers/constants.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/models/user_model.dart';
import 'package:cuidapet_mobile/app/services/address/address_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final LocalStorage _localStorage;
  final LocalSecureStorage _secureStorage;
  final AddressService _addressService;

  @readonly
  UserModel? _userLogged;

  AuthStoreBase(
      {required LocalStorage localStorage,
      required LocalSecureStorage secureStorage,
      required AddressService addressService})
      : _localStorage = localStorage,
        _secureStorage = secureStorage,
        _addressService = addressService;

  @action
  Future<void> loadUserLogged() async {
    final userJson =
        await _localStorage.read<String>(Constants.localStorageUserDataKey);
    if (userJson != null) {
      _userLogged = UserModel.fromJson(userJson);
    } else {
      _userLogged = UserModel.empty();
    }

    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user == null) {
        await logout();
      }
    });
  }

  @action
  Future<void> logout() async {
    await _localStorage.clear();
    await _secureStorage.clear();
    await _addressService.deleteAll();
    _userLogged = UserModel.empty();
  }
}
