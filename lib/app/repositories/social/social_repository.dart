import 'package:cuidapet_mobile/app/models/social_network.dart';

abstract interface class SocialRepository {
  Future<SocialNetwork> googleLogin();
  Future<SocialNetwork> facebookLogin();
}
