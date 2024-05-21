import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
import 'package:cuidapet_mobile/app/models/social_network.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './social_repository.dart';

class SocialRepositoryImpl implements SocialRepository {
  @override
  Future<SocialNetwork> facebookLogin() {
    // TODO: implement facebookLogin
    throw UnimplementedError();
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
