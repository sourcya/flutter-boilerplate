import 'package:flutter_boilerplate/app/app_launch/auth/data/data_sources/auth0_auth_data_source.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/data_sources/remote_auth_data_source.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/models/models.dart';
import 'package:flutter_boilerplate/core/preferences/preference_manger.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:playx/playx.dart';

/// This is the repository where we should handle the data and return it to the controller.
class AuthRepository {
  final RemoteAuthDataSource remoteAuthDataSource;

  final Auth0AuthDataSource auth0DataSource;

  final MyPreferenceManger preferenceManger;

  AuthRepository({
    required this.remoteAuthDataSource,
    required this.auth0DataSource,
    required this.preferenceManger,
  });

  Future<NetworkResult<User>> loginViaAuth0({
    LoginMethod method = LoginMethod.auth0Web,
    bool saveUser = true,
  }) async {
    try {
      final res = await auth0DataSource.login(method: method);

      if (saveUser) {
        return _handleSavingUser(result: res, loginMethod: method);
      }

      return res.mapDataAsyncInIsolate(
        mapper: (data) {
          return NetworkResult<User>.success(data.toUser());
        },
      );
    } catch (e) {
      Sentry.captureException(e);
      return const NetworkResult<User>.error(
        UnableToProcessException(
          errorMessage: AppTrans.unableToProcess,
          statusCode: 400,
        ),
      );
    }
  }

  Future<bool> get isAuthenticatedViaAuth0 async {
    final res = await auth0DataSource.hasValidCredentials;
    return res;
  }

  Future<User?> getAuth0AuthedUser() async {
    final res = await auth0DataSource.getCredentials();
    if (res != null) {
      final user = User(
        jwtToken: res.accessToken,
        info: UserInfo(
          documentId: res.idToken,
          username: res.idToken,
          email: res.idToken,
          provider: res.idToken,
        ),
      );
      return user;
    }
    return null;
  }

  Future<NetworkResult<User>> loginViaEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final NetworkResult<ApiUser> result = await remoteAuthDataSource.login(
        email: email,
        password: password,
      );
      return _handleSavingUser(result: result, loginMethod: LoginMethod.email);
    } catch (e) {
      Sentry.captureException(e);
      return const NetworkResult<User>.error(
        UnableToProcessException(
          errorMessage: AppTrans.unableToProcess,
          statusCode: 400,
        ),
      );
    }
  }

  Future<NetworkResult<User>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      final res = await remoteAuthDataSource.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );
      return _handleSavingUser(result: res, loginMethod: LoginMethod.email);
    } catch (e) {
      Sentry.captureException(e);
      return const NetworkResult<User>.error(
        UnableToProcessException(
          errorMessage: AppTrans.unableToProcess,
          statusCode: 400,
        ),
      );
    }
  }

  Future<bool> saveApiUser({
    required ApiUser user,
    LoginMethod? loginMethod,
  }) async {
    final String token = user.jwt;
    final ApiUserInfo info = user.userInfo;

    await preferenceManger.saveToken(token);
    await preferenceManger.saveUser(info);
    final role = user.role?.type != null
        ? UserRoleType.fromString(user.role!.type)
        : null;
    await preferenceManger.saveUserRoleType(role);
    if (loginMethod != null) {
      await preferenceManger.saveLoginMethod(loginMethod);
    }
    return true;
  }

  Future<bool> saveUser({
    required User user,
    LoginMethod? loginMethod,
  }) async {
    try {
      final ApiUser apiUser = await user.mapAsync(mapper: (e) => e.toApiUser());
      return saveApiUser(user: apiUser, loginMethod: loginMethod);
    } catch (e) {
      Sentry.captureException(e);

      return false;
    }
  }

  Future<NetworkResult<User>> _handleSavingUser({
    required NetworkResult<ApiUser> result,
    required LoginMethod loginMethod,
  }) async {
    try {
      if (result is NetworkError<ApiUser>) {
        return NetworkResult.error(result.error);
      } else {
        final data = (result as NetworkSuccess<ApiUser>).data;
        final bool saved =
            await saveApiUser(user: data, loginMethod: loginMethod);
        if (!saved) {
          return const NetworkResult<User>.error(
            UnexpectedErrorException(errorMessage: AppTrans.emptyResponse),
          );
        }

        return result.mapDataAsyncInIsolate(
          mapper: (data) {
            return NetworkResult.success(data.toUser());
          },
        );
      }
    } catch (e) {
      Sentry.captureException(e);
      return const NetworkResult<User>.error(
        UnableToProcessException(
          errorMessage: AppTrans.unableToProcess,
          statusCode: 400,
        ),
      );
    }
  }

  Future<NetworkResult<User>> otpLogin({
    required String phoneNumber,
  }) async {
    final result = await remoteAuthDataSource.otpLogin(
      phoneNumber: phoneNumber,
    );
    return _handleSavingUser(result: result, loginMethod: LoginMethod.email);
  }

  Future<NetworkResult<User>> verifyOtpCode({required String pin}) async {
    final NetworkResult<ApiUser> result = await remoteAuthDataSource.verifyOtpCode(
      pin: pin,
    );
    return _handleSavingUser(result: result, loginMethod: LoginMethod.email);
  }

// Future<void> saveLoginInfo({
//   required String email,
//   required String password,
// }) {
//   return _preferenceManger.saveLoginInfo(email: email, password: password);
// }
//
// Future<({String? email, String? password})> getLoginInfo() async {
//   final email = await _preferenceManger.getSavedEmail();
//   final password = await _preferenceManger.getSavedPassword();
//   return (email: email, password: password);
// }
}
