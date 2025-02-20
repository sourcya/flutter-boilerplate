import 'package:flutter_boilerplate/app/app_launch/auth/data/models/models.dart';
import 'package:playx/playx.dart';

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
    return NetworkResult.success(
      ApiUser(
        jwt: 'sasdfasfafa',
        userInfo: ApiUserInfo(
          username: 'mohamed.ahmed',
          email: 'mohamed.ahmed@gmail.com',
          id: 11,
          documentId: '21',
        ),
      ),
    );
  }

  Future<NetworkResult<ApiUser>> otpLogin({
    required String phoneNumber,
  }) async {
    await Future.delayed(const Duration(seconds: 3));
    return NetworkResult.success(
      ApiUser(
        jwt: 'sasdfasfafa',
        userInfo: ApiUserInfo(
          username: 'mohamed.ahmed',
          email: 'mohamed.ahmed@gmail.com',
          id: 21,
          documentId: '31',
        ),
      ),
    );
  }

  Future<NetworkResult<ApiUser>> verifyOtpCode({required String pin}) async {
    await Future.delayed(const Duration(seconds: 3));
    return NetworkResult.success(
      ApiUser(
        jwt: 'sasdfasfafa',
        userInfo: ApiUserInfo(
          username: 'mohamed.ahmed',
          email: 'mohamed.ahmed@gmail.com',
          id: 21,
          documentId: '31',
        ),
      ),
    );
  }

  Future<NetworkResult<ApiUser>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    await Future.delayed(const Duration(seconds: 3));
    return NetworkResult.success(
      ApiUser(
        jwt: 'sasdfasfafa',
        userInfo: ApiUserInfo(
          username: 'mohamed.ahmed',
          email: 'mohamed.ahmed@gmail.com',
          id: 21,
          documentId: '31',
        ),
      ),
    );
  }
}
