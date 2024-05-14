abstract interface class LocalStorage {
  Future<V?> read<V>(String key);
  Future<void> write<V>(String key, V value);
  Future<bool> contains(String key);
  Future<void> remove(String key);
  Future<void> clear();
}

//abstract interface class LocalSecureStorage {}
