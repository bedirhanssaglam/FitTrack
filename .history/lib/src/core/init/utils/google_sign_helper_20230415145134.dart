import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../base/models/firebase_user.dart';
import '../cache/cache_manager.dart';

class GoogleSignHelper {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<GoogleSignInAccount?> signIn() async {
    final user = await _googleSignIn.signIn();
    if (user != null) {
      log(user.email);
      return user;
    }
    return null;
  }

  GoogleSignInAccount get user => _googleSignIn.currentUser!;

  Future<GoogleSignInAuthentication?> googleAuthtencite() async {
    if (await _googleSignIn.isSignedIn()) {
      final user = _googleSignIn.currentUser;
      final userData = await user?.authentication;
      await CacheManager.instance
          .saveString(SharedKeys.token, userData!.accessToken!);
      return userData;
    }
    return null;
  }

  Future<GoogleSignInAccount?> signOut() async {
    final user = await _googleSignIn.signOut();
    if (user != null) {
      log(user.email);
      await CacheManager.instance.clear();
      return user;
    }
    return null;
  }
}

abstract class IUserService {
  Future<UserCredential> signInWithGoogle();
  Future<void> signOut();
}

class UserService extends IUserService {
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

  @override
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? accountOwner = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication auth = await accountOwner!.authentication;
    final userCredential = GoogleAuthProvider.credential(
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );
    CacheManager.instance
        .saveString(SharedKeys.token, userCredential.accessToken!);
    return await FirebaseAuth.instance.signInWithCredential(userCredential);
  }

  @override
  Future<void> signOut() async {
    CacheManager.instance.clear();
    return await _fireBaseAuth.signOut();
  }
}

class FirebaseService {
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
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
