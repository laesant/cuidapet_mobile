import 'dart:convert';

class ConfirmLogin {
  final String accessToken;
  final String refreshToken;

  ConfirmLogin({
    required this.accessToken,
    required this.refreshToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }

  factory ConfirmLogin.fromMap(Map<String, dynamic> map) {
    return ConfirmLogin(
      accessToken: map['access_token'] ?? '',
      refreshToken: map['refresh_token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ConfirmLogin.fromJson(String source) =>
      ConfirmLogin.fromMap(json.decode(source));
}
