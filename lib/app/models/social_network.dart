class SocialNetwork {
  final String id;
  final String name;
  final String email;
  final String type;
  final String accessToken;
  final String? avatar;

  SocialNetwork({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
    required this.accessToken,
    this.avatar,
  });
}
