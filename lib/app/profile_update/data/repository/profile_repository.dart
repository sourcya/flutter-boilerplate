import 'dart:io';
import 'package:flutter_boilerplate/app/app_launch/auth/data/models/models.dart';
import 'package:flutter_boilerplate/app/profile_update/data/datasource/profile_datasource.dart';
import 'package:flutter_boilerplate/app/profile_update/data/datasource/profile_local_datasource.dart';
import 'package:flutter_boilerplate/core/models/models.dart';
import 'package:flutter_boilerplate/core/preferences/preference_manger.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:playx/playx.dart';

class ProfileRepository {
  final ProfileDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;
  final MyPreferenceManger preferenceManger;

  ProfileRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.preferenceManger,
  });

  static ProfileRepository get instance => getIt.get<ProfileRepository>();

  Future<NetworkResult<ApiUserInfo>> getUserProfile({
    bool forceRefresh = false,
  }) async {
    try {
      if (!forceRefresh) {
        final cachedProfile = await localDataSource.getCachedUserProfile();
        if (cachedProfile != null) {
          return NetworkResult.success(cachedProfile);
        }
      }

      final remoteResult = await remoteDataSource.getUserProfile();

      if (remoteResult is NetworkSuccess<ApiUserInfo>) {
        await localDataSource.cacheUserProfile(remoteResult.data);
        await preferenceManger.saveUser(remoteResult.data);
        return remoteResult;
      } else {
        final cachedProfile = await localDataSource.getCachedUserProfile();
        if (cachedProfile != null) {
          return NetworkResult.success(cachedProfile);
        }
        return remoteResult;
      }
    } catch (e) {
      Sentry.captureException(e);

      final cachedProfile = await localDataSource.getCachedUserProfile();
      if (cachedProfile != null) {
        return NetworkResult.success(cachedProfile);
      }

      return const NetworkResult.error(
        UnableToProcessException(
          errorMessage: AppTrans.unableToProcess,
          statusCode: 400,
        ),
      );
    }
  }

  Future<NetworkResult<ApiUserInfo>> updateProfile({
    required String? firstName,
    required String? lastName,
    String? email,
    String? mobileNumber,
    File? profileImageFile,
    String? jwtToken,
  }) async {
    try {
      final currentProfile = await localDataSource.getCachedUserProfile();
      if (currentProfile != null) {
        await localDataSource.createProfileBackup(currentProfile);
      }

      MediaItem? imageToUpload;
      if (profileImageFile != null) {
        final localImagePath =
            await localDataSource.saveProfileImageLocally(profileImageFile);
        if (localImagePath != null) {
          imageToUpload = MediaItem(url: localImagePath);
        }
      }

      final remoteResult = await remoteDataSource.updateProfile(
        firstName: firstName,
        lastName: lastName,
        email: email,
        mobileNumber: mobileNumber,
        profileImage: imageToUpload,
        jwtToken: jwtToken,
      );

      if (remoteResult is NetworkSuccess<ApiUserInfo>) {
        final updatedProfile = remoteResult.data;

        await localDataSource.cacheUserProfile(updatedProfile);
        await preferenceManger.saveUser(updatedProfile);

        await localDataSource.clearPendingUpdates();

        return remoteResult;
      } else {
        final pendingUpdates = <String, dynamic>{};
        if (firstName != null) pendingUpdates['firstName'] = firstName;
        if (lastName != null) pendingUpdates['lastName'] = lastName;
        if (email != null) pendingUpdates['email'] = email;
        if (mobileNumber != null) pendingUpdates['mobileNumber'] = mobileNumber;
        if (profileImageFile != null) pendingUpdates['hasImageUpdate'] = true;

        await localDataSource.savePendingUpdates(pendingUpdates);

        await localDataSource.updateCachedProfile(
          firstName: firstName,
          lastName: lastName,
          email: email,
          mobileNumber: mobileNumber,
          image: imageToUpload,
        );

        return remoteResult;
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

  Future<NetworkResult<ApiUserInfo>> updateProfileImage({
    required File imageFile,
    String? jwtToken,
  }) async {
    try {
      final localImagePath =
          await localDataSource.saveProfileImageLocally(imageFile);

      if (localImagePath == null) {
        return const NetworkResult.error(
          UnableToProcessException(
            errorMessage: 'Failed to save image locally',
            statusCode: 400,
          ),
        );
      }

      final imageToUpload = MediaItem(url: localImagePath);

      final remoteResult = await remoteDataSource.updateProfileImage(
        profileImage: imageToUpload,
        jwtToken: jwtToken,
      );

      if (remoteResult is NetworkSuccess<ApiUserInfo>) {
        await localDataSource.cacheUserProfile(remoteResult.data);
        await preferenceManger.saveUser(remoteResult.data);
      } else {
        await localDataSource.savePendingUpdates({'hasImageUpdate': true});

        final currentProfile = await localDataSource.getCachedUserProfile();
        if (currentProfile != null) {
          await localDataSource.updateCachedProfile(image: imageToUpload);
        }
      }

      return remoteResult;
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

  Future<bool> syncPendingUpdates() async {
    try {
      final pendingUpdates = await localDataSource.getPendingUpdates();
      if (pendingUpdates.isEmpty) return true;

      final success = await remoteDataSource.updateProfile(
        firstName: pendingUpdates['firstName'] as String? ?? "",
        lastName: pendingUpdates['lastName'] as String? ?? "",
        email: pendingUpdates['email'] as String? ?? "",
        mobileNumber: pendingUpdates['mobileNumber'] as String? ?? "",
        profileImage: pendingUpdates['hasImageUpdate'] == true
            ? await _getPendingImageUpdate()
            : null,
      );

      if (success is NetworkSuccess) {
        await localDataSource.clearPendingUpdates();
        await localDataSource.cacheUserProfile(success.data);
        await preferenceManger.saveUser(success.data);
        return true;
      }

      return false;
    } catch (e) {
      Sentry.captureException(e);
      return false;
    }
  }

  Future<MediaItem?> _getPendingImageUpdate() async {
    try {
      final imagePath = await localDataSource.getLocalProfileImagePath();
      if (imagePath != null) {
        return MediaItem(url: imagePath);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> hasPendingUpdates() async {
    return await localDataSource.hasPendingUpdates();
  }

  Future<NetworkResult<bool>> deleteProfile({String? jwtToken}) async {
    try {
      final result = await remoteDataSource.deleteProfile(jwtToken: jwtToken);

      if (result is NetworkSuccess) {
        await localDataSource.clearProfileCache();
        await localDataSource.deleteLocalProfileImage();
        await preferenceManger.signOut();
      }

      return result;
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

  Future<NetworkResult<bool>> changePassword({
    required String currentPassword,
    required String newPassword,
    String? jwtToken,
  }) async {
    return await remoteDataSource.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      jwtToken: jwtToken,
    );
  }

  Future<NetworkResult<bool>> requestEmailVerification(
      {String? jwtToken}) async {
    return await remoteDataSource.requestEmailVerification(jwtToken: jwtToken);
  }

  Future<void> cleanCache() async {
    await localDataSource.cleanOldCacheData();
  }

  Future<String?> getLocalProfileImagePath() async {
    return await localDataSource.getLocalProfileImagePath();
  }

  Future<bool> isCacheValid() async {
    return await localDataSource.isCacheValid();
  }
}
