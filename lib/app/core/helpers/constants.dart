class Constants {
  Constants._();

  static const String envBaseUrlKey = 'base_url';
  static const String envRestClientConnectTimeout =
      'rest_client_connect_timeout';
  static const String envRestClientReceiveTimeout =
      'rest_client_receive_timeout';

  static const String localStorageUserDataKey = 'local_storage_user_data';
  static const String localStorageAccessTokenKey = 'local_storage_access_token';
  static const String localStorageRefreshTokenKey =
      'local_storage_refresh_token';
  static const String localStorageDefaultAddressDataKey =
      'local_storage_default_address_data';

  static const String restClientAuthRequired = 'auth_required';
}
