import 'package:flutter_boilerplate/app/app_launch/auth/data/data_sources/remote_auth_data_source.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/data_sources/test_auth_data_source.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/models/models.dart';
import 'package:flutter_boilerplate/core/network/network.dart';
import 'package:flutter_boilerplate/core/preferences/preference_manger.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:playx/playx.dart';

/// Handles authentication via a configurable email/password API call.
class AuthRepository {
  final RemoteAuthDataSource remoteAuthDataSource;
  final MyPreferenceManger preferenceManger;

  AuthRepository({
    required this.remoteAuthDataSource,
    required this.preferenceManger,
  });

  static AuthRepository get instance => getIt.get<AuthRepository>();

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

  Future<NetworkResult<User>> otpLogin({
    required String phoneNumber,
  }) async {
    try {
      final result = await remoteAuthDataSource.otpLogin(
        phoneNumber: phoneNumber,
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

  Future<NetworkResult<User>> verifyOtpCode({
    required String pin,
  }) async {
    try {
      final result = await remoteAuthDataSource.verifyOtpCode(pin: pin);
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

  Future<NetworkResult<User>> _handleSavingUser({
    required NetworkResult<ApiUser> result,
    required LoginMethod loginMethod,
  }) async {
    try {
      if (result is NetworkError<ApiUser>) {
        return NetworkResult.error(result.error);
      } else {
        final data = (result as NetworkSuccess<ApiUser>).data;
        final bool saved = await saveApiUser(
          user: data,
          loginMethod: loginMethod,
        );
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

  Future<NetworkResult<bool>> forgetPassword({
    required String email,
  }) async {
    try {
      return remoteAuthDataSource.forgetPassword(email: email);
    } catch (e) {
      Sentry.captureException(e);
      return const NetworkResult<bool>.error(
        UnableToProcessException(
          errorMessage: AppTrans.unableToProcess,
          statusCode: 400,
        ),
      );
    }
  }

  Future<NetworkResult<String>> verifyForgetPasswordOtpCode({
    required String code,
    required String email,
  }) async {
    try {
      return remoteAuthDataSource.verifyForgetPasswordOtpCode(
        code: code,
        email: email,
      );
    } catch (e) {
      Sentry.captureException(e);
      return const NetworkResult<String>.error(
        UnableToProcessException(
          errorMessage: AppTrans.unableToProcess,
          statusCode: 400,
        ),
      );
    }
  }

  Future<NetworkResult<bool>> resetPassword({
    required String password,
    required String token,
  }) async {
    try {
      return remoteAuthDataSource.resetPassword(
        password: password,
        token: token,
      );
    } catch (e) {
      Sentry.captureException(e);
      return const NetworkResult<bool>.error(
        UnableToProcessException(
          errorMessage: AppTrans.unableToProcess,
          statusCode: 400,
        ),
      );
    }
  }

  Future<NetworkResult<User>> changePassword({
    required String password,
    required String oldPassword,
  }) async {
    try {
      final method = await preferenceManger.loginMethod ?? LoginMethod.email;
      final res = await remoteAuthDataSource.changePassword(
        password: password,
        oldPassword: oldPassword,
      );
      return _handleSavingUser(result: res, loginMethod: method);
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

  static void registerInstance() {
    if (!getIt.isRegistered<AuthRepository>()) {
      final client = ApiClient.client;
      getIt.registerSingleton<AuthRepository>(
        AuthRepository(
          remoteAuthDataSource: TestAuthDataSource(client: client),
          preferenceManger: MyPreferenceManger.instance,
        ),
      );
    }
  }

  static Future<void> handleSignOut() async {
    await MyPreferenceManger.instance.signOut();
  }

  /// Verifies the stored token via `GET /users/me`.
  Future<NetworkResult<ApiUserInfo>> validateSession() {
    return remoteAuthDataSource.getProfile();
  }
}
