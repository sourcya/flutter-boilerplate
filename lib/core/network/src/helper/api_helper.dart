import 'package:flutter_boilerplate/app/app_launch/auth/data/data_sources/auth0_auth_data_source.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/models/models.dart';
import 'package:flutter_boilerplate/core/models/src/media_item.dart';
import 'package:flutter_boilerplate/core/network/network.dart';
import 'package:flutter_boilerplate/core/preferences/preference_manger.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:playx/playx.dart';

class ApiHelper {
  static final ApiHelper _instance = ApiHelper._internal();

  factory ApiHelper() {
    return _instance;
  }

  ApiHelper._internal();

  static ApiHelper get instance => _instance;

  final _client = ApiClient.client;
  final _preferenceManger = MyPreferenceManger.instance;
  final _auth0DataSource = Auth0AuthDataSource();

  static NetworkResult<T> unableToProcessError<T>() =>
      const NetworkResult.error(
        UnableToProcessException(
          errorMessage: AppTrans.unableToProcess,
          statusCode: 400,
        ),
      );

  Future<bool> isLoggedIn({bool checkAuth0 = true}) async {
    try {
      final loginMethod = await _preferenceManger.loginMethod;

      final checkAuth0Credentials =
          checkAuth0 && loginMethod != null && loginMethod != LoginMethod.email;

      final isLoggedInAndSavedToPref = await _preferenceManger.isLoggedIn;

      if (checkAuth0Credentials) {
        return await _auth0DataSource.isLoggedIn && isLoggedInAndSavedToPref;
      }
      return isLoggedInAndSavedToPref;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isLoggedOut({bool checkAuth0 = true}) async =>
      !(await isLoggedIn(checkAuth0: checkAuth0));

  Future<void> logout() async {
    await _preferenceManger.signOut();

    final loginMethod = await _preferenceManger.loginMethod;

    final logOutFromAuth0 =
        loginMethod != null && loginMethod != LoginMethod.email;

    if (logOutFromAuth0) {
      try {
        await _auth0DataSource.logout();
      } catch (e) {
        Sentry.captureException(e);
      }
    }
  }

  Future<String?> get profileImageUrl async =>
      (await _auth0DataSource.getCredentials())?.user.pictureUrl.toString();

  Future<NetworkResult<MediaItem>> uploadImage({
    required MediaItem image,
    String? jwtToken,
  }) async {
    try {
      final data = await image.toFormData();
      if (data == null) {
        return const NetworkResult.error(
          EmptyResponseException(
            statusCode: 400,
            errorMessage: AppTrans.emptyResponse,
          ),
        );
      }

      final token = jwtToken ?? await MyPreferenceManger.instance.token;

      final res = await _client.postList(
        Endpoints.upload,
        body: data,
        attachCustomHeaders: false,
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
        },
        fromJson: (json) => MediaItem.fromJson(json),
        contentType: 'multipart/form-data',
      );

      return res.mapDataAsyncInIsolate(
        mapper: (data) async {
          return NetworkSuccess(
            data[0],
          );
        },
      );
    } catch (e) {
      Sentry.captureException(e);
      return const NetworkResult.error(
        UnexpectedErrorException(
          errorMessage: AppTrans.unexpectedError,
        ),
      );
    }
  }

  Future<NetworkResult<ApiUserInfo>> updateUser({
    required ApiUserInfo user,
    String? jwtToken,
  }) async {
    // bool isImageError = false;
    // if (updatedImage != null && updatedImage.id == null) {
    //   final uploadRes = await ApiHelper.instance.uploadImage(
    //     image: updatedImage,
    //     jwtToken: token,
    //   );
    //   uploadRes.when(
    //     success: (MediaItem success) {
    //       updatedImage = success;
    //     },
    //     error: (NetworkException error) {
    //       isImageError = true;
    //     },
    //   );
    // }
    return updateProfileName(
      firstName: user.firstName,
      lastName: user.lastName,
      jwtToken: jwtToken,
    );
  }

  Future<NetworkResult<ApiUserInfo>> updateProfileName({
    required String? firstName,
    required String? lastName,
    String? jwtToken,
  }) async {
    final token = jwtToken ?? await MyPreferenceManger.instance.token;

    return _client.put(
      Endpoints.updateUser,
      body: {
        'firstName': firstName,
        'lastName': lastName,
        // if (!isImageError) 'image': updatedImage?.id,
      },
      headers: {
        'Authorization': 'Bearer $token',
      },
      fromJson: ApiUserInfo.fromJson,
      attachCustomHeaders: false,
    );
  }
}
