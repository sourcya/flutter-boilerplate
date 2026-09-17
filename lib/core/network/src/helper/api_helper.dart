import 'package:flutter_boilerplate/app/app_launch/auth/data/models/models.dart';
import 'package:flutter_boilerplate/core/models/models.dart';
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

  static NetworkResult<T> unableToProcessError<T>() =>
      const NetworkResult.error(
        UnableToProcessException(
          errorMessage: AppTrans.unableToProcess,
          statusCode: 400,
        ),
      );

  Future<bool> isLoggedIn() async {
    try {
      return _preferenceManger.isLoggedIn;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isLoggedOut() async => !(await isLoggedIn());

  Future<void> logout() async {
    await _preferenceManger.signOut();
  }

  Future<String?> get profileImageUrl async => null;

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
        mapper: (data) {
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
  }) {
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
      },
      headers: {
        'Authorization': 'Bearer $token',
      },
      fromJson: ApiUserInfo.fromJson,
      attachCustomHeaders: false,
    );
  }
}
