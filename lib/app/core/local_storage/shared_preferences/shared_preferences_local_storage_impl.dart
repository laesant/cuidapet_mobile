import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesLocalStorageImpl implements LocalStorage {
  Future<SharedPreferences> get _instance => SharedPreferences.getInstance();
  @override
  Future<void> clear() async {
    final sp = await _instance;
    sp.clear();
  }

  @override
  Future<bool> contains(String key) async {
    final sp = await _instance;
    return sp.containsKey(key);
  }

  @override
  Future<V?> read<V>(String key) async {
    final sp = await _instance;
    return sp.get(key) as V?;
  }

  @override
  Future<void> remove(String key) async {
    final sp = await _instance;
    sp.remove(key);
  }

  @override
  Future<void> write<V>(String key, V value) async {
    final sp = await _instance;
    switch (V) {
      case const (String):
        await sp.setString(key, value as String);
        break;
      case const (int):
        await sp.setInt(key, value as int);
        break;
      case const (double):
        await sp.setDouble(key, value as double);
        break;
      case const (bool):
        await sp.setBool(key, value as bool);
        break;
      case const (List<String>):
        await sp.setStringList(key, value as List<String>);
        break;
      default:
        throw Exception('Type not supported: $V');
    }
  }
}
