import 'package:playx/playx.dart';

import '../../../../../core/preferences/preference_manger.dart';
import '../../../../../core/resources/translation/app_translations.dart';
import '../data_sources/test_auth_data_source.dart';
import '../models/api_user.dart';
import '../models/user.dart';

/// This is the repository where we should handle the data and return it to the controller.
class AuthRepository {
  final TestAuthDataSource _dataSource = TestAuthDataSource();
  final MyPreferenceManger _preferenceManger = MyPreferenceManger.instance;

  static final AuthRepository _instance = AuthRepository._internal();

  factory AuthRepository() {
    return _instance;
  }

  AuthRepository._internal();

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
          return NetworkResult.error(
            EmptyResponseException(errorMessage: AppTrans.emptyResponse.tr),
          );
        }
      },
      error: (NetworkException exception) {},
    );

    return result;
  }
}
