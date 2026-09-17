import 'package:flutter_boilerplate/app/app_launch/auth/data/data_sources/remote_auth_data_source.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/models/models.dart';
import 'package:flutter_boilerplate/core/preferences/preference_manger.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:playx/playx.dart';

///This class is responsible of retrieving data from the network.
class TestAuthDataSource extends RemoteAuthDataSource {
  TestAuthDataSource({
    required super.client,
  });

  @override
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
          firstName: 'Mohamed',
          lastName: 'Ahmed',
          email: 'mohamed.ahmed@gmail.com',
          id: 11,
          documentId: '21',
        ),
      ),
    );
  }

  @override
  Future<NetworkResult<ApiUser>> otpLogin({
    required String phoneNumber,
  }) async {
    await Future.delayed(const Duration(seconds: 3));
    return NetworkResult.success(
      ApiUser(
        jwt: 'sasdfasfafa',
        userInfo: ApiUserInfo(
          username: 'mohamed.ahmed',
          firstName: 'Mohamed',
          lastName: 'Ahmed',
          email: 'mohamed.ahmed@gmail.com',
          id: 21,
          documentId: '31',
        ),
      ),
    );
  }

  @override
  Future<NetworkResult<ApiUser>> verifyOtpCode({required String pin}) async {
    await Future.delayed(const Duration(seconds: 3));
    return NetworkResult.success(
      ApiUser(
        jwt: 'sasdfasfafa',
        userInfo: ApiUserInfo(
          username: 'mohamed.ahmed',
          firstName: 'Mohamed',
          lastName: 'Ahmed',
          email: 'mohamed.ahmed@gmail.com',
          id: 21,
          documentId: '31',
        ),
      ),
    );
  }

  @override
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
          firstName: 'Mohamed',
          lastName: 'Ahmed',
          email: 'mohamed.ahmed@gmail.com',
          id: 21,
          documentId: '31',
        ),
      ),
    );
  }

  @override
  Future<NetworkResult<bool>> forgetPassword({
    required String email,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return const NetworkResult.success(true);
  }

  @override
  Future<NetworkResult<String>> verifyForgetPasswordOtpCode({
    required String code,
    required String email,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return const NetworkResult.success('reset-password-token');
  }

  @override
  Future<NetworkResult<bool>> resetPassword({
    required String password,
    required String token,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return const NetworkResult.success(true);
  }

  @override
  Future<NetworkResult<ApiUser>> changePassword({
    required String password,
    required String oldPassword,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return NetworkResult.success(
      ApiUser(
        jwt: 'sasdfasfafa',
        userInfo: ApiUserInfo(
          username: 'mohamed.ahmed',
          firstName: 'Mohamed',
          lastName: 'Ahmed',
          email: 'mohamed.ahmed@gmail.com',
          id: 11,
          documentId: '21',
        ),
      ),
    );
  }

  @override
  Future<NetworkResult<ApiUserInfo>> getProfile() async {
    final token = await MyPreferenceManger.instance.token;
    if (token == null || token.isEmpty) {
      return const NetworkResult.error(
        ApiException(
          errorMessage: AppTrans.unauthorizedRequest,
          statusCode: 401,
        ),
      );
    }
    return NetworkResult.success(
      ApiUserInfo(
        username: 'mohamed.ahmed',
        firstName: 'Mohamed',
        lastName: 'Ahmed',
        email: 'mohamed.ahmed@gmail.com',
        id: 11,
        documentId: '21',
      ),
    );
  }
}
