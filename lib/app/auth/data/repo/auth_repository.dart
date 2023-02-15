import 'package:flutter_boilerplate/app/auth/data/data_sources/remote_auth_data_source.dart';
import 'package:flutter_boilerplate/core/preferences/preference_manger.dart';

import '../../../../core/network/models/network_exception.dart';
import '../../../../core/network/models/network_result.dart';
import '../models/api_user.dart';
import '../models/user.dart';

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
          return const NetworkResult.error(NetworkExceptions.emptyResponse());
        }
      },
      error: (NetworkExceptions exception) {},
    );

    return result;
  }
}
