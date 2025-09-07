import 'dart:convert';
import 'dart:io';
import 'package:flutter_boilerplate/app/app_launch/auth/data/models/models.dart';
import 'package:flutter_boilerplate/core/models/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:playx/playx.dart';

class ProfileLocalDataSource {
  // Cache keys
  static const String _userProfileKey = 'cached_user_profile';
  static const String _profileImagePathKey = 'cached_profile_image_path';
  static const String _profileCacheTimeKey = 'profile_cache_time';
  static const String _pendingUpdatesKey = 'pending_profile_updates';

  // Cache duration (24 hours)
  static const Duration _cacheValidDuration = Duration(hours: 24);

  ProfileLocalDataSource();

  Future<bool> cacheUserProfile(ApiUserInfo? userProfile) async {
    try {
      final profileJson = jsonEncode(userProfile?.toJson());
      await PlayxSecurePrefs.setString(_userProfileKey, profileJson);
      await PlayxSecurePrefs.setString(
        _profileCacheTimeKey,
        DateTime.now().toIso8601String(),
      );
      return true;
    } catch (e) {
      Sentry.captureException(e);
      return false;
    }
  }

  Future<ApiUserInfo?> getCachedUserProfile() async {
    try {
      final cachedProfile = await PlayxSecurePrefs.getString(_userProfileKey);
      if (cachedProfile.isEmpty) {
        return null;
      }

      // Check if cache is still valid
      if (!await isCacheValid()) {
        await clearProfileCache();
        return null;
      }

      final profileMap = jsonDecode(cachedProfile) as Map<String, dynamic>;
      return ApiUserInfo.fromJson(profileMap);
    } catch (e) {
      Sentry.captureException(e);
      await clearProfileCache(); // Clear corrupted cache
      return null;
    }
  }

  Future<bool> isCacheValid() async {
    try {
      final cacheTimeString =
          await PlayxSecurePrefs.getString(_profileCacheTimeKey);
      if (cacheTimeString.isEmpty) {
        return false;
      }

      final cacheTime = DateTime.parse(cacheTimeString);
      final now = DateTime.now();
      final difference = now.difference(cacheTime);

      return difference <= _cacheValidDuration;
    } catch (e) {
      return false;
    }
  }

  Future<void> clearProfileCache() async {
    try {
      await PlayxSecurePrefs.remove(_userProfileKey);
      await PlayxSecurePrefs.remove(_profileCacheTimeKey);
      await PlayxSecurePrefs.remove(_profileImagePathKey);
    } catch (e) {
      Sentry.captureException(e);
    }
  }

  Future<String?> saveProfileImageLocally(File imageFile) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final profileDir = Directory('${directory.path}/profile_images');

      if (!await profileDir.exists()) {
        await profileDir.create(recursive: true);
      }

      final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedImagePath = '${profileDir.path}/$fileName';

      await imageFile.copy(savedImagePath);
      await PlayxSecurePrefs.setString(_profileImagePathKey, savedImagePath);

      return savedImagePath;
    } catch (e) {
      Sentry.captureException(e);
      return null;
    }
  }

  Future<String?> getLocalProfileImagePath() async {
    try {
      final imagePath = await PlayxSecurePrefs.getString(_profileImagePathKey);
      if (await File(imagePath).exists()) {
        return imagePath;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteLocalProfileImage() async {
    try {
      final imagePath = await getLocalProfileImagePath();
      if (imagePath != null) {
        final file = File(imagePath);
        if (await file.exists()) {
          await file.delete();
        }
        await PlayxSecurePrefs.remove(_profileImagePathKey);
      }
      return true;
    } catch (e) {
      Sentry.captureException(e);
      return false;
    }
  }

  Future<bool> savePendingUpdates(Map<String, dynamic> updates) async {
    try {
      final existingUpdates = await getPendingUpdates();
      existingUpdates.addAll(updates);

      final updatesJson = jsonEncode(existingUpdates);
      await PlayxSecurePrefs.setString(_pendingUpdatesKey, updatesJson);
      return true;
    } catch (e) {
      Sentry.captureException(e);
      return false;
    }
  }

  Future<Map<String, dynamic>> getPendingUpdates() async {
    try {
      final updatesString =
          await PlayxSecurePrefs.getString(_pendingUpdatesKey);
      if (updatesString.isEmpty) {
        return <String, dynamic>{};
      }

      final updatesMap = jsonDecode(updatesString) as Map<String, dynamic>;
      return updatesMap;
    } catch (e) {
      Sentry.captureException(e);
      return <String, dynamic>{};
    }
  }

  Future<bool> clearPendingUpdates() async {
    try {
      await PlayxSecurePrefs.remove(_pendingUpdatesKey);
      return true;
    } catch (e) {
      Sentry.captureException(e);
      return false;
    }
  }

  Future<bool> hasPendingUpdates() async {
    try {
      final updates = await getPendingUpdates();
      return updates.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateCachedProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? mobileNumber,
    MediaItem? image,
  }) async {
    try {
      final cachedProfile = await getCachedUserProfile();
      if (cachedProfile == null) return false;

      final updatedProfile = cachedProfile.copyWith(
        firstName: firstName,
        lastName: lastName,
        email: email,
        mobileNumber: mobileNumber,
        image: image,
      );

      return await cacheUserProfile(updatedProfile);
    } catch (e) {
      Sentry.captureException(e);
      return false;
    }
  }

  Future<Map<String, dynamic>?> getProfileBackup() async {
    try {
      const backupKey = '${_userProfileKey}_backup';
      final backupString = await PlayxSecurePrefs.getString(backupKey);
      if (backupString.isEmpty) {
        return null;
      }

      return jsonDecode(backupString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  Future<bool> createProfileBackup(ApiUserInfo profile) async {
    try {
      const backupKey = '${_userProfileKey}_backup';
      final backupData = {
        'profile': profile.toJson(),
        'timestamp': DateTime.now().toIso8601String(),
      };

      await PlayxSecurePrefs.setString(
        backupKey,
        jsonEncode(backupData),
      );
      return true;
    } catch (e) {
      Sentry.captureException(e);
      return false;
    }
  }

  Future<void> cleanOldCacheData() async {
    try {
      // Clean old profile images
      final directory = await getApplicationDocumentsDirectory();
      final profileDir = Directory('${directory.path}/profile_images');

      if (await profileDir.exists()) {
        final files = profileDir.listSync();
        final now = DateTime.now();

        for (final file in files) {
          if (file is File) {
            final stat = await file.stat();
            final age = now.difference(stat.modified);

            // Delete files older than 7 days
            if (age.inDays > 7) {
              await file.delete();
            }
          }
        }
      }
    } catch (e) {
      Sentry.captureException(e);
    }
  }
}
