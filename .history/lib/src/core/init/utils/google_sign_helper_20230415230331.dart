import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../cache/cache_manager.dart';

class GoogleSignInHelper {
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
      scopes: <String>["email"],
    ).signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    log("TOKEN : ${credential.accessToken}");
    CacheManager.instance.saveString(SharedKeys.token, credential.accessToken!);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signOut() {
    CacheManager.instance.clear();
    FirebaseAuth.instance.signOut();
  }
}
