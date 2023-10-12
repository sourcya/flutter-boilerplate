import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/core/preferences/env_manger.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:playx/playx.dart';

import '../../../../../core/config/constant.dart';
import '../../../../../core/utils/result.dart';

class GoogleAuthDataSource {
  static final GoogleAuthDataSource _instance =
      GoogleAuthDataSource._internal();

  factory GoogleAuthDataSource() {
    return _instance;
  }

  GoogleAuthDataSource._internal();


  Future<Result<GoogleSignInAccount>> signIn() async {
    try {
      final googleSignIn = GoogleSignIn(
        clientId: await EnvManger.instance.googleSignInClientId,
        serverClientId: Constants.googleSignInServerId,);

      final user = await googleSignIn.signIn();
      if (user == null) return const Result.error("Couldn't retrieve user");

      final userAuth = await user.authentication;
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
      final googleSignIn = GoogleSignIn(
        clientId: await EnvManger.instance.googleSignInClientId,
        serverClientId: Constants.googleSignInServerId,);

      final user = await googleSignIn.disconnect();
      if (user == null) return const Result.error("Couldn't retrieve user");
      return Result.success(user);
    } on PlatformException catch (error) {
      return Result.error(
          error.message ?? 'Could not sign out with Google account',);
    } catch (error) {
      return const Result.error('Could not sign out with Google account');
    }
  }

  Future<bool> isSignedIn() async {
    final googleSignIn = GoogleSignIn(
      clientId: await EnvManger.instance.googleSignInClientId,
      serverClientId: Constants.googleSignInServerId,);
    return googleSignIn.isSignedIn();
  }
}
