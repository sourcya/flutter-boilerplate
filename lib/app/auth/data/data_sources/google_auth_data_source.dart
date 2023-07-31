import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:playx/playx.dart' hide Result;

import '../../../../core/config/keys.dart';
import '../../../../core/utils/result.dart';

class GoogleAuthDataSource {
  static final GoogleAuthDataSource _instance =
      GoogleAuthDataSource._internal();

  factory GoogleAuthDataSource() {
    return _instance;
  }

  GoogleAuthDataSource._internal();

  final _googleSignIn = GoogleSignIn(
      clientId: Keys.googleSignInClientId,
      serverClientId: Keys.googleSignInServerId,);

  Future<Result<GoogleSignInAccount>> signIn() async {
    try {
      final user = await _googleSignIn.signIn();
      if (user == null) return const Result.error("Couldn't retrieve user");

      final userAuth = await user.authentication;
      Fimber.d(
          'Google Sign In : ${user.email} : ${user.displayName} , ${user.photoUrl} :'
          'id : ${userAuth.idToken} access : ${userAuth.accessToken} ');
      return Result.success(user);
    } on PlatformException catch (error) {
      Fimber.e('Google Sign In Error : $error');
      return Result.error(
          error.message ?? 'Could not sign in with Google account',);
    } catch (error) {
      Fimber.e('Google Sign In Error : $error');

      return const Result.error('Could not sign in with Google account');
    }
  }

  Future<Result<GoogleSignInAccount>> signOut() async {
    try {
      final user = await _googleSignIn.disconnect();
      if (user == null) return const Result.error("Couldn't retrieve user");
      return Result.success(user);
    } on PlatformException catch (error) {
      return Result.error(
          error.message ?? 'Could not sign out with Google account',);
    } catch (error) {
      return const Result.error('Could not sign out with Google account');
    }
  }

  Future<bool> isSignedIn() {
    return _googleSignIn.isSignedIn();
  }
}
