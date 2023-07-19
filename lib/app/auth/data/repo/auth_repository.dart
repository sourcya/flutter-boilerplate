import 'package:flutter_boilerplate/core/network/exception/custom_exception_message.dart';
import 'package:playx/playx.dart';

import '../../../../core/preferences/preference_manger.dart';
import '../data_sources/remote_auth_data_source.dart';
import '../models/api_user.dart';
import '../models/user.dart';

/// This is the repository where we should handle the data and return it to the controller.
class AuthRepository {
  RemoteAuthDataSource remoteDataSource = RemoteAuthDataSource();
  MyPreferenceManger preferenceManger = MyPreferenceManger.instance;

  static final AuthRepository _instance = AuthRepository._internal();

  factory AuthRepository() {
    return _instance;
  }

  AuthRepository._internal();

  Future<NetworkResult<ApiUser>> login({
    required String email,
    required String password,
  }) async {
    final NetworkResult<ApiUser> result = await remoteDataSource.login(
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
    final res = await remoteDataSource.register(
      email: email,
      password: password,
    );
    return handleSavingUser(res);
  }

  NetworkResult<ApiUser> handleSavingUser(NetworkResult<ApiUser> result) {
    result.when(
      success: (ApiUser userData) async {
        final String? token = userData.jwt;
        final User? user = userData.user;
        if (token != null) {
          await preferenceManger.saveToken(token);
          if (user != null) {
            await preferenceManger.saveUser(user);
          }
        } else {
          return const NetworkResult.error(EmptyResponseException(exceptionMessage: CustomExceptionMessage()));
        }
      },
      error: (NetworkException exception) {},
    );

    return result;
  }
}
