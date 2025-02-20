import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/models/models.dart';
import 'package:flutter_boilerplate/core/config/constant.dart';
import 'package:flutter_boilerplate/core/models/src/media_item.dart';
import 'package:flutter_boilerplate/core/network/network.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:playx/playx.dart';

class Auth0AuthDataSource {
  static final Auth0AuthDataSource _instance = Auth0AuthDataSource._internal();

  factory Auth0AuthDataSource() {
    return _instance;
  }

  Auth0AuthDataSource._internal();

  final _auth0 = Auth0(Constants.auth0Domain, Constants.auth0ClientId);
  final _auth0Web = Auth0Web(Constants.auth0Domain, Constants.auth0WebClientId);

  final PlayxNetworkClient _client = Get.find<PlayxNetworkClient>();

  Future<bool> get hasValidCredentials async {
    try {
      return PlayxPlatform.isWeb
          ? await _auth0Web.hasValidCredentials()
          : await _auth0.credentialsManager.hasValidCredentials();
    } catch (e) {
      return false;
    }
  }

  Future<bool> get isLoggedIn async => await hasValidCredentials;

  // Use a Universal Link callback URL on iOS 17.4+ / macOS 14.4+
  // useHTTPS is ignored on Android

  Future<void> init() async {
    if (PlayxPlatform.isWeb) {
      try {
        await _auth0Web.onLoad();
      } catch (e) {
        Sentry.captureException(e);
      }
    }
  }

  Future<NetworkResult<ApiUser>> login({
    LoginMethod method = LoginMethod.auth0Web,
  }) async {
    return PlayxPlatform.isWeb
        ? _loginWithWeb(method: method)
        : _loginWithMobile(method: method);
  }

  Future<NetworkResult<ApiUser>> _loginWithMobile({
    LoginMethod method = LoginMethod.auth0Web,
  }) async {
    try {
      final credentials = await _auth0.webAuthentication().login(
        useHTTPS: true,
        parameters: {
          'connection': method.auth0Connection,
        },
      );

      final res = await _client.get(
        Endpoints.loginViaAuth0,
        query: {
          'access_token': credentials.accessToken,
        },
        fromJson: (json) => ApiUser.fromJson(
          json,
          image: MediaItem(
            url: credentials.user.pictureUrl.toString(),
          ),
        ),
        attachCustomHeaders: false,
      );

      return _updateUserInfo(res: res, credentials: credentials);
    } on WebAuthenticationException catch (e) {
      Sentry.captureException(e);
      return NetworkResult.error(
        Auth0exception(
          errorCode: e.code,
          auth0ErrorMessage: e.message,
          errorDetails: e.details,
        ),
      );
    } catch (e) {
      Sentry.captureException(e);
      return const NetworkResult.error(
        UnexpectedErrorException(errorMessage: AppTrans.unexpectedError),
      );
    }
  }

  Future<NetworkResult<ApiUser>> _loginWithWeb({
    LoginMethod method = LoginMethod.auth0Web,
  }) async {
    try {
      final credentials = await _auth0Web.loginWithPopup(
        parameters: {
          'connection': method.auth0Connection,
        },
      );

      final res = await _client.get(
        Endpoints.loginViaAuth0,
        query: {
          'access_token': credentials.accessToken,
        },
        fromJson: (json) => ApiUser.fromJson(
          json,
          image: MediaItem(
            url: credentials.user.pictureUrl.toString(),
          ),
        ),
        attachCustomHeaders: false,
      );

      return _updateUserInfo(res: res, credentials: credentials);
    } on WebAuthenticationException catch (e) {
      Sentry.captureException(e);
      return NetworkResult.error(
        Auth0exception(
          errorCode: e.code,
          auth0ErrorMessage: e.message,
          errorDetails: e.details,
        ),
      );
    } catch (e) {
      Sentry.captureException(e);
      return const NetworkResult.error(
        UnexpectedErrorException(errorMessage: AppTrans.unexpectedError),
      );
    }
  }

  Future<String?> get profileImageUrl async =>
      (await getCredentials())?.user.pictureUrl.toString();

  Future<NetworkResult<ApiUser>> _updateUserInfo({
    required NetworkResult<ApiUser> res,
    required Credentials credentials,
  }) async {
    try {
      if (res is NetworkSuccess<ApiUser>) {
        final user = res.data.userInfo;
        final token = res.data.jwt;

        //   // Update only when user first name or last name is null
        //   if (user.firstName == null ||
        //       user.firstName!.isEmpty ||
        //       user.lastName == null ||
        //       user.lastName!.isEmpty) {
        //     final firstName = user.firstName ??
        //         credentials.user.givenName ??
        //         credentials.user.name;
        //     final lastName = user.lastName ?? credentials.user.familyName;
        //     final imageUrl = credentials.user.pictureUrl.toString();
        //     final image = user.image ?? MediaItem(url: imageUrl);
        //
        //     final updatedUser = user.copyWith(
        //       firstName: firstName,
        //       lastName: lastName,
        //       image: image,
        //     );
        //
        //     final updateUserRes = await _profileDataSource.updateUser(
        //       user: updatedUser,
        //       jwtToken: token,
        //     );
        //     if (updateUserRes is NetworkSuccess<ApiUserInfo> &&
        //         token.isNotEmpty) {
        //       return NetworkSuccess(
        //         ApiUser(
        //           jwt: res.data.jwt,
        //           userInfo: updateUserRes.data,
        //         ),
        //       );
        //     }
        //   }
      }
      return res;
    } catch (e) {
      Sentry.captureException(e);
      return const NetworkResult.error(
        UnexpectedErrorException(errorMessage: AppTrans.unexpectedError),
      );
    }
  }

  Future<Credentials?> getCredentials() async {
    try {
      final res = PlayxPlatform.isWeb
          ? await _auth0Web.credentials()
          : await _auth0.credentialsManager.credentials();
      return res;
    } on CredentialsManagerException {
      return null;
    } catch (e) {
      Sentry.captureException(e);
      return null;
    }
  }

  Future<void> logout() async {
    try {
      if (PlayxPlatform.isWeb) {
        return _auth0Web.logout();
      }
      return _auth0.webAuthentication().logout();
    } catch (e) {
      Sentry.captureException(e);
    }
  }
}
