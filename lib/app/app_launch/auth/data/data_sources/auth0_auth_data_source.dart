import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/models/api_user.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/models/auth0Exception.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/models/login_method.dart';
import 'package:flutter_boilerplate/core/config/constant.dart';
import 'package:flutter_boilerplate/core/network/endpoints/endpoints.dart';
import 'package:flutter_boilerplate/core/resources/translation/app_translations.dart';
import 'package:playx/playx.dart';

class Auth0AuthDataSource {
  static final Auth0AuthDataSource _instance = Auth0AuthDataSource._internal();

  factory Auth0AuthDataSource() {
    return _instance;
  }

  Auth0AuthDataSource._internal();

  final _auth0 = Auth0(Constants.auth0Domain, Constants.auth0ClientId);

  final PlayxNetworkClient _client = Get.find<PlayxNetworkClient>();

  Future<bool> get hasValidCredentials async =>
      await _auth0.credentialsManager.hasValidCredentials();

  Future<bool> get isLoggedIn async => await hasValidCredentials;

  // Use a Universal Link callback URL on iOS 17.4+ / macOS 14.4+
  // useHTTPS is ignored on Android
  Future<NetworkResult<ApiUser>> login({
    LoginMethod method = LoginMethod.auth0Web,
  }) async {
    try {
      final credentials = await _auth0.webAuthentication().login(
        useHTTPS: true,
        parameters: {
          'connection': method.auth0Connection,
        },
      );

      return _client.get(
        Endpoints.login,
        query: {
          'access_token': credentials.accessToken,
        },
        fromJson: (json) => ApiUser.fromJsonAndCredentials(
          json: json,
          credentials: credentials,
        ),
        attachCustomHeaders: false,
      );
    } on WebAuthenticationException catch (e) {
      Sentry.captureException(e);
      return NetworkResult.error(
        Auth0exception(
          errorCode: e.code,
          auth0ErrorMessage: e.message,
          errorDetails: e.details,
        ),
      );
    } on Exception catch (e) {
      Sentry.captureException(e);
      return const NetworkResult.error(
        UnexpectedErrorException(errorMessage: AppTrans.unexpectedError),
      );
    }
  }

  Future<Credentials?> getCredentials() async {
    try {
      final res = await _auth0.credentialsManager.credentials();
      return res;
    } on CredentialsManagerException {
      return null;
    }
  }

  Future<void> logout() {
    return _auth0.webAuthentication().logout();
  }
}
