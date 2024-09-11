import 'package:playx/playx.dart';

import '../../../../../core/preferences/preference_manger.dart';
import '../../../../../core/resources/translation/app_translations.dart';
import '../data_sources/auth0_auth_data_source.dart';
import '../data_sources/test_auth_data_source.dart';
import '../models/api_user.dart';
import '../models/login_method.dart';
import '../models/user.dart';

/// This is the repository where we should handle the data and return it to the controller.
class AuthRepository {
  final TestAuthDataSource _dataSource = TestAuthDataSource();
  final _auth0DataSource = Auth0AuthDataSource();

  final MyPreferenceManger _preferenceManger = MyPreferenceManger.instance;

  static final AuthRepository _instance = AuthRepository._internal();

  factory AuthRepository() {
    return _instance;
  }

  AuthRepository._internal();

  Future<NetworkResult<ApiUser>> loginViaAuth0({
    LoginMethod method = LoginMethod.auth0Web,
  }) async {
    final res = await _auth0DataSource.login(method: method);
    return handleSavingUser(res);
  }

  Future<bool> get isAuthenticatedViaAuth0 async {
    final res = await _auth0DataSource.hasValidCredentials;
    return res;
  }

  Future<bool> isLoggedIn({bool checkAuth0Credentials = true}) async {
    if (checkAuth0Credentials) {
      return await _auth0DataSource.isLoggedIn && _preferenceManger.isLoggedIn;
    }
    return _preferenceManger.isLoggedIn;
  }

  Future<bool> isLoggedOut({bool checkAuth0Credentials = true}) async =>
      !(await isLoggedIn(checkAuth0Credentials: checkAuth0Credentials));

  Future<ApiUser?> getAuth0AuthedUser() async {
    final res = await _auth0DataSource.getCredentials();
    if (res != null) {
      final user = ApiUser(
        jwt: res.accessToken,
        user: User(
          id: res.idToken,
          username: res.idToken,
          email: res.idToken,
          provider: res.idToken,
        ),
      );
      return user;
    }
    return null;
  }

  Future<NetworkResult<ApiUser>> login({
    required String email,
    required String password,
  }) async {
    final NetworkResult<ApiUser> result = await _dataSource.login(
      email: email,
      password: password,
    );
    return handleSavingUser(result);
  }

  Future<NetworkResult<ApiUser>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final res = await _dataSource.register(
      email: email,
      password: password,
    );
    return handleSavingUser(res);
  }

  Future<NetworkResult<ApiUser>> otpLogin({
    required String phoneNumber,
  }) async {
    final result = await _dataSource.otpLogin(
      phoneNumber: phoneNumber,
    );
    return handleSavingUser(result);
  }

  Future<NetworkResult<ApiUser>> verifyOtpCode({required String pin}) async {
    final NetworkResult<ApiUser> result = await _dataSource.verifyOtpCode(
      pin: pin,
    );
    return handleSavingUser(result);
  }

  NetworkResult<ApiUser> handleSavingUser(NetworkResult<ApiUser> result) {
    result.when(
      success: (ApiUser userData) async {
        final String? token = userData.jwt;
        final User? user = userData.user;
        if (token != null) {
          await _preferenceManger.saveToken(token);
          if (user != null) {
            await _preferenceManger.saveUser(user);
          }
        } else {
          return const NetworkResult.error(
            EmptyResponseException(
              errorMessage: AppTrans.emptyResponse,
              statusCode: 400,
            ),
          );
        }
      },
      error: (NetworkException exception) {},
    );

    return result;
  }

  Future<void> logout({bool logOutFromAuth0 = true}) async {
    await _preferenceManger.signOut();
    await Future.delayed(const Duration(seconds: 2));
    if (logOutFromAuth0) {
      try {
        await _auth0DataSource.logout();
      } catch (e) {
        Sentry.captureException(e);
      }
    }
  }
}
