import 'package:flutter_boilerplate/app/app_launch/auth/data/models/models.dart';
import 'package:flutter_boilerplate/core/models/models.dart';
import 'package:flutter_boilerplate/core/network/network.dart';
import 'package:flutter_boilerplate/core/network/src/helper/api_helper.dart';
import 'package:flutter_boilerplate/core/preferences/preference_manger.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:playx/playx.dart';

///This class is responsible of retrieving data from the network.
class RemoteAuthDataSource {
  final PlayxNetworkClient client;

  RemoteAuthDataSource({
    required this.client,
  });

  Future<NetworkResult<ApiUser>> login({
    required String email,
    required String password,
  }) async {
    final res = await client.post<ApiUser>(
      Endpoints.login,
      attachCustomHeaders: false,
      body: {
        'identifier': email,
        'password': password,
      },
      fromJson: ApiUser.fromJson,
    );
    if (res is NetworkError<ApiUser>) {
      final error = res.error;
      if (error is ApiException &&
          error.message == 'Invalid identifier or password') {
        return const NetworkResult.error(
          ApiException(
            errorMessage: AppTrans.emailOrPasswordIncorrect,
          ),
        );
      }
    }
    return res;
  }

  Future<NetworkResult<ApiUser>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    final res = await client.post<ApiUser>(
      Endpoints.register,
      attachCustomHeaders: false,
      body: {
        'username': email,
        'email': email,
        'password': password,
      },
      fromJson: ApiUser.fromJson,
    );

    return _updateUserInfo(res: res, firstName: firstName, lastName: lastName);
  }

  Future<NetworkResult<ApiUser>> _updateUserInfo({
    required NetworkResult<ApiUser> res,
    required String firstName,
    required String lastName,
    MediaItem? image,
  }) async {
    if (res is NetworkSuccess<ApiUser>) {
      final user = res.data.userInfo;
      final token = res.data.jwt;

      final updatedUser = user.copyWith(
        firstName: firstName,
        lastName: lastName,
        image: image,
      );

      final updateUserRes = await ApiHelper.instance.updateUser(
        user: updatedUser,
        jwtToken: token,
      );
      if (updateUserRes is NetworkSuccess<ApiUserInfo> && token.isNotEmpty) {
        return NetworkSuccess(
          ApiUser(
            jwt: res.data.jwt,
            userInfo: updateUserRes.data,
          ),
        );
      }
    }
    return res;
  }

  Future<NetworkResult<ApiUser>> otpLogin({
    required String phoneNumber,
  }) async {
    final res = await client.post<ApiUser>(
      Endpoints.login,
      attachCustomHeaders: false,
      body: {
        'identifier': phoneNumber,
      },
      fromJson: ApiUser.fromJson,
    );
    return res;
  }

  Future<NetworkResult<ApiUser>> verifyOtpCode({required String pin}) {
    return client.post<ApiUser>(
      Endpoints.register,
      attachCustomHeaders: false,
      body: {
        'pin': pin,
      },
      fromJson: ApiUser.fromJson,
    );
  }

  Future<NetworkResult<bool>> forgetPassword({
    required String email,
  }) {
    return client.post<bool>(
      Endpoints.forgetPassword,
      attachCustomHeaders: false,
      body: {
        'email': email,
      },
      shouldHandleUnauthorizedRequest: false,
      fromJson: (json) {
        if (json == true) return true;
        if (json is Map<String, dynamic>) {
          return json['ok'] == true;
        }
        return false;
      },
    );
  }

  Future<NetworkResult<String>> verifyForgetPasswordOtpCode({
    required String code,
    required String email,
  }) async {
    final res = await client.post<String>(
      Endpoints.verifyForgetPasswordOtpCode,
      attachCustomHeaders: false,
      body: {'email': email, 'otp': code},
      shouldHandleUnauthorizedRequest: false,
      fromJson: (json) {
        if (json is Map<String, dynamic>) {
          return json['jwt'] as String? ?? '';
        }
        return '';
      },
    );

    if (res is NetworkError<String>) {
      final raw = res.error.message;
      if (raw.contains('Invalid OTP')) {
        return const NetworkResult.error(
          ApiException(errorMessage: AppTrans.invalidOtpCodeError),
        );
      }
      if (raw.contains('OTP has expired')) {
        return const NetworkResult.error(
          ApiException(errorMessage: AppTrans.passwordOtpExpiredMessage),
        );
      }
    }
    return res;
  }

  Future<NetworkResult<bool>> resetPassword({
    required String password,
    required String token,
  }) {
    return client.post<bool>(
      Endpoints.resetPassword,
      attachCustomHeaders: false,
      body: {
        'password': password,
        'passwordConfirmation': password,
      },
      shouldHandleUnauthorizedRequest: false,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
      fromJson: (_) => true,
    );
  }

  Future<NetworkResult<ApiUser>> changePassword({
    required String password,
    required String oldPassword,
  }) async {
    final res = await client.post<ApiUser>(
      Endpoints.changePassword,
      body: {
        'currentPassword': oldPassword,
        'password': password,
        'passwordConfirmation': password,
      },
      shouldHandleUnauthorizedRequest: false,
      fromJson: ApiUser.fromJson,
    );

    if (res is NetworkError<ApiUser>) {
      final raw = res.error.message;
      if (raw.contains('current password is invalid')) {
        return const NetworkResult.error(
          ApiException(errorMessage: AppTrans.invalidCurrentPasswordError),
        );
      }
    }
    return res;
  }

  /// Lightweight session check (`GET /users/me`).
  ///
  /// [shouldHandleUnauthorizedRequest] is `false` so a 401/403 here does not
  /// recurse into [SessionManager.handleUnauthorizedResponse].
  Future<NetworkResult<ApiUserInfo>> getProfile() async {
    final token = await MyPreferenceManger.instance.token ?? '';
    return client.get<ApiUserInfo>(
      Endpoints.profile,
      fromJson: ApiUserInfo.fromJson,
      attachCustomHeaders: false,
      shouldHandleUnauthorizedRequest: false,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
  }
}
