import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
import 'package:cuidapet_mobile/app/models/social_network.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './social_repository.dart';

class SocialRepositoryImpl implements SocialRepository {
  @override
  Future<SocialNetwork> facebookLogin() async {
    final facebookAuth = FacebookAuth.instance;
    final result = await facebookAuth.login();
    switch (result.status) {
      case LoginStatus.success:
        final userData = await facebookAuth.getUserData();
        return SocialNetwork(
            id: userData['id'],
            name: userData['name'],
            email: userData['email'],
            type: 'Facebook',
            avatar: userData['picture']['data']['url'],
            accessToken: result.accessToken?.tokenString ?? '');
      case LoginStatus.cancelled:
        throw Failure(message: 'Login cancelado');
      case LoginStatus.failed:
      case LoginStatus.operationInProgress:
        throw Failure(message: result.message);
    }
  }

  @override
  Future<SocialNetwork> googleLogin() async {
    final googleSignIn = GoogleSignIn();
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.disconnect();
    }

    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser?.authentication;
    if (googleAuth != null && googleUser != null) {
      return SocialNetwork(
          id: googleAuth.idToken ?? '',
          name: googleUser.displayName ?? '',
          email: googleUser.email,
          type: 'Google',
          avatar: googleUser.photoUrl,
          accessToken: googleAuth.accessToken ?? '');
    } else {
      throw Failure(message: 'Erro ao realizar login com o Google.');
    }
  }
}
