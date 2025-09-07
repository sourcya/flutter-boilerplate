import 'package:flutter_boilerplate/app/app_launch/auth/data/models/models.dart';
import 'package:flutter_boilerplate/core/models/models.dart';
import 'package:flutter_boilerplate/core/network/network.dart';
import 'package:flutter_boilerplate/core/network/src/helper/api_helper.dart';
import 'package:flutter_boilerplate/core/preferences/preference_manger.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:playx/playx.dart';

/// This class is responsible for retrieving profile data from the remote server.
class ProfileDataSource {
  final PlayxNetworkClient client;

  ProfileDataSource({
    required this.client,
  });

  /// Get current user profile information
  Future<NetworkResult<ApiUserInfo>> getUserProfile({
    String? jwtToken,
  }) async {
    try {
      final token = jwtToken ?? await MyPreferenceManger.instance.token;

      if (token == null) {
        return const NetworkResult.error(
          UnauthorizedRequestException(errorMessage: "Unauthorized"),
        );
      }

      final res = await client.get<ApiUserInfo>(
        Endpoints.profile,
        headers: {'Authorization': 'Bearer $token'},
        fromJson: ApiUserInfo.fromJson,
        attachCustomHeaders: false,
      );

      return res;
    } catch (e) {
      Sentry.captureException(e);
      return const NetworkResult.error(
        UnableToProcessException(
          errorMessage: AppTrans.unableToProcess,
          statusCode: 400,
        ),
      );
    }
  }

  /// Update user profile information
  Future<NetworkResult<ApiUserInfo>> updateProfile({
    required String? firstName,
    required String? lastName,
    String? email,
    String? mobileNumber,
    MediaItem? profileImage,
    String? jwtToken,
  }) async {
    try {
      final token = jwtToken ?? await MyPreferenceManger.instance.token;

      if (token == null) {
        return const NetworkResult.error(
          UnauthorizedRequestException(errorMessage: "Unauthorized"),
        );
      }

      // Upload profile image first if provided
      MediaItem? uploadedImage;
      if (profileImage != null && profileImage.id == null) {
        final uploadRes = await ApiHelper.instance.uploadImage(
          image: profileImage,
          jwtToken: token,
        );

        uploadRes.when(
          success: (MediaItem success) {
            uploadedImage = success;
          },
          error: (NetworkException error) {
            // Continue without image if upload fails
            uploadedImage = null;
          },
        );
      } else {
        uploadedImage = profileImage;
      }

      final res = await client.put<ApiUserInfo>(
        Endpoints.updateUser,
        body: {
          if (firstName != null) 'firstName': firstName,
          if (lastName != null) 'lastName': lastName,
          if (email != null) 'email': email,
          if (mobileNumber != null) 'mobileNumber': mobileNumber,
          if (uploadedImage?.id != null) 'image': uploadedImage!.id,
        },
        headers: {'Authorization': 'Bearer $token'},
        fromJson: ApiUserInfo.fromJson,
        attachCustomHeaders: false,
      );

      return res;
    } catch (e) {
      Sentry.captureException(e);
      return const NetworkResult.error(
        UnableToProcessException(
          errorMessage: AppTrans.unableToProcess,
          statusCode: 400,
        ),
      );
    }
  }

  /// Update only profile image
  Future<NetworkResult<ApiUserInfo>> updateProfileImage({
    required MediaItem profileImage,
    String? jwtToken,
  }) async {
    try {
      final token = jwtToken ?? await MyPreferenceManger.instance.token;

      if (token == null) {
        return const NetworkResult.error(
          UnauthorizedRequestException(errorMessage: "Unauthorized"),
        );
      }

      // Upload image first
      final uploadRes = await ApiHelper.instance.uploadImage(
        image: profileImage,
        jwtToken: token,
      );

      if (uploadRes is NetworkError) {
        return NetworkResult.error(
          uploadRes.error ??
              const UnableToProcessException(
                errorMessage: AppTrans.unableToProcess,
                statusCode: 400,
              ),
        );
      }

      final uploadedImage = (uploadRes as NetworkSuccess<MediaItem>).data;

      // Update user with new image
      final res = await client.put<ApiUserInfo>(
        Endpoints.updateUser,
        body: {'image': uploadedImage.id},
        headers: {'Authorization': 'Bearer $token'},
        fromJson: ApiUserInfo.fromJson,
        attachCustomHeaders: false,
      );

      return res;
    } catch (e) {
      Sentry.captureException(e);
      return const NetworkResult.error(
        UnableToProcessException(
          errorMessage: AppTrans.unableToProcess,
          statusCode: 400,
        ),
      );
    }
  }

  /// Delete user profile
  Future<NetworkResult<bool>> deleteProfile({
    String? jwtToken,
  }) async {
    try {
      final token = jwtToken ?? await MyPreferenceManger.instance.token;

      if (token == null) {
        return const NetworkResult.error(
          UnauthorizedRequestException(errorMessage: "Unauthorized"),
        );
      }

      final res = await client.delete(
        Endpoints.deleteUser,
        headers: {'Authorization': 'Bearer $token'},
        fromJson: (json) => json as Map<String, dynamic>,
        attachCustomHeaders: false,
      );

      if (res is NetworkSuccess) {
        return const NetworkResult.success(true);
      } else {
        return const NetworkResult.error(
          UnableToProcessException(
            errorMessage: AppTrans.unableToProcess,
            statusCode: 400,
          ),
        );
      }
    } catch (e) {
      Sentry.captureException(e);
      return const NetworkResult.error(
        UnableToProcessException(
          errorMessage: AppTrans.unableToProcess,
          statusCode: 400,
        ),
      );
    }
  }

  /// Change user password
  Future<NetworkResult<bool>> changePassword({
    required String currentPassword,
    required String newPassword,
    String? jwtToken,
  }) async {
    try {
      final token = jwtToken ?? await MyPreferenceManger.instance.token;

      if (token == null) {
        return const NetworkResult.error(
          UnauthorizedRequestException(errorMessage: "Unauthorized"),
        );
      }

      final res = await client.post<Map<String, dynamic>>(
        Endpoints.changePassword,
        body: {
          'currentPassword': currentPassword,
          'password': newPassword,
          'passwordConfirmation': newPassword,
        },
        headers: {'Authorization': 'Bearer $token'},
        fromJson: (json) => json as Map<String, dynamic>,
        attachCustomHeaders: false,
      );

      if (res is NetworkSuccess) {
        return const NetworkResult.success(true);
      } else {
        final error = (res as NetworkError).error;
        if (error is ApiException &&
            error.message.contains('password') == true) {
          return const NetworkResult.error(
            ApiException(errorMessage: "Password does not match"),
          );
        }
        return NetworkResult.error(error);
      }
    } catch (e) {
      Sentry.captureException(e);
      return const NetworkResult.error(
        UnableToProcessException(
          errorMessage: AppTrans.unableToProcess,
          statusCode: 400,
        ),
      );
    }
  }

  /// Request email verification
  Future<NetworkResult<bool>> requestEmailVerification({
    String? jwtToken,
  }) async {
    try {
      final token = jwtToken ?? await MyPreferenceManger.instance.token;

      if (token == null) {
        return const NetworkResult.error(
          UnauthorizedRequestException(errorMessage: "Unauthorized"),
        );
      }

      final res = await client.post<Map<String, dynamic>>(
        Endpoints.sendEmailConfirmation,
        headers: {'Authorization': 'Bearer $token'},
        fromJson: (json) => json as Map<String, dynamic>,
        attachCustomHeaders: false,
      );

      if (res is NetworkSuccess) {
        return const NetworkResult.success(true);
      } else {
        return NetworkResult.error((res as NetworkError).error);
      }
    } catch (e) {
      Sentry.captureException(e);
      return const NetworkResult.error(
        UnableToProcessException(
          errorMessage: AppTrans.unableToProcess,
          statusCode: 400,
        ),
      );
    }
  }
}
