import 'package:playx/playx.dart';

import '../models/api_user.dart';
import '../models/user.dart';

///This class is responsible of retrieving data from the network.
class TestAuthDataSource {
  static final TestAuthDataSource _instance = TestAuthDataSource._internal();

  factory TestAuthDataSource() {
    return _instance;
  }

  TestAuthDataSource._internal();

  Future<NetworkResult<ApiUser>> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 3));
    return NetworkResult.success(ApiUser(
        jwt: 'sasdfasfafa',
        user: User(
            username: 'mohamed.ahmed',
            email: 'mohamed.ahmed@gmail.com',
            id: '121')));
  }

  Future<NetworkResult<ApiUser>> otpLogin({
    required String phoneNumber,
  }) async {
    await Future.delayed(const Duration(seconds: 3));
    return NetworkResult.success(ApiUser(
        jwt: 'sasdfasfafa',
        user: User(
            username: 'mohamed.ahmed',
            email: 'mohamed.ahmed@gmail.com',
            id: '121')));
  }

  Future<NetworkResult<ApiUser>> verifyOtpCode({required String pin}) async {
    await Future.delayed(const Duration(seconds: 3));
    return NetworkResult.success(ApiUser(
        jwt: 'sasdfasfafa',
        user: User(
            username: 'mohamed.ahmed',
            email: 'mohamed.ahmed@gmail.com',
            id: '121')));
  }

  Future<NetworkResult<ApiUser>> register(
      {required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 3));
    return NetworkResult.success(ApiUser(
        jwt: 'sasdfasfafa',
        user: User(
            username: 'mohamed.ahmed',
            email: 'mohamed.ahmed@gmail.com',
            id: '121')));
  }
}
