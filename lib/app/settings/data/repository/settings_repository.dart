import 'dart:convert';

import 'package:flutter_boilerplate/app/settings/data/datasource/settings_datasource.dart';
import 'package:flutter_boilerplate/app/settings/data/model/settings_model.dart';
import 'package:flutter_boilerplate/core/preferences/preference_manger.dart'
    show MyPreferenceManger;
import 'package:local_auth/local_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:playx/playx.dart';

abstract class SettingsRepository {
  Future<Settings> getSettings();
  Future<void> saveSettings(Settings settings);
  Future<void> resetSettings();
  Future<void> syncSettingsToServer();

  Future<void> enablePushNotifications();
  Future<void> disablePushNotifications();
  Future<void> enableEmailNotifications();
  Future<void> disableEmailNotifications();

  Future<bool> isBiometricAvailable();
  Future<bool> authenticateWithBiometric();
  Future<void> setBiometricEnabled(bool enabled);
  Future<bool> is2FAEnabled();

  Future<void> enableAutoBackup();
  Future<void> disableAutoBackup();
  Future<void> enableDataSync();
  Future<void> disableDataSync();
  Future<StorageInfo> getStorageUsage();
  Future<void> clearCache();
  Future<String> exportData();
  Future<void> importData(String data);
}

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsDatasource _remoteDatasource;
  final SettingsDatasource _localDatasource;
  final LocalAuthentication _localAuth;

  SettingsRepositoryImpl({
    required SettingsDatasource remoteDatasource,
    required SettingsDatasource localDatasource,
    LocalAuthentication? localAuth,
  })  : _remoteDatasource = remoteDatasource,
        _localDatasource = localDatasource,
        _localAuth = localAuth ?? LocalAuthentication();

  static SettingsRepositoryImpl get instance =>
      getIt.get<SettingsRepositoryImpl>();

  Future<String> _currentUserId() async {
    final user = await MyPreferenceManger.instance.getSavedUser();
    return (user?.id ?? '').toString();
  }

  @override
  Future<Settings> getSettings() async {
    try {
      final remoteResult =
          await _remoteDatasource.getUserSettings(await _currentUserId());
      remoteResult.when(
        success: (settings) async {
          await _localDatasource.updateUserSettings(settings);
        },
        error: (exception) {
          /* final localResult =
              await _localDatasource.getUserSettings(await _currentUserId());
          localResult.when(
            success: (settings) {},
            error: (_) {
              final settings = Settings(
                pushNotificationsEnabled: false,
                emailNotificationsEnabled: false,
                biometricEnabled: false,
                autoBackup: false,
                dataSync: false,
                lastUpdated: DateTime.now(),
              );
            },
          ); */
        },
      );
      return remoteResult.data!;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      final settings = Settings(
        pushNotificationsEnabled: false,
        emailNotificationsEnabled: false,
        biometricEnabled: false,
        autoBackup: false,
        dataSync: false,
        lastUpdated: DateTime.now(),
      );
      return settings;
    }
  }

  @override
  Future<void> saveSettings(Settings settings) async {
    try {
      await _localDatasource.updateUserSettings(settings);

      final result = await _remoteDatasource.updateUserSettings(settings);

      result.when(
        success: (updatedSettings) async {
          await _localDatasource.updateUserSettings(updatedSettings);
        },
        error: (exception) {
          Sentry.captureException(exception);
        },
      );
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      throw Exception('Failed to save settings: $e');
    }
  }

  @override
  Future<void> resetSettings() async {
    try {
      final result =
          await _remoteDatasource.resetSettings(await _currentUserId());

      result.when(
        success: (settings) async {
          await _localDatasource.resetSettings(await _currentUserId());
        },
        error: (exception) async {
          await _localDatasource.resetSettings(await _currentUserId());
        },
      );
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      throw Exception('Failed to reset settings: $e');
    }
  }

  @override
  Future<void> syncSettingsToServer() async {
    try {
      final localResult =
          await _localDatasource.getUserSettings(await _currentUserId());

      localResult.when(
        success: (settings) async {
          final syncResult = await _remoteDatasource.syncSettings(settings);
          syncResult.when(
            success: (success) {
              if (!success) {
                throw Exception('Sync returned false');
              }
            },
            error: (exception) => throw exception,
          );
        },
        error: (exception) => throw exception,
      );
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      throw Exception('Failed to sync settings: $e');
    }
  }

  @override
  Future<void> enablePushNotifications() async {
    try {
      // Request permission
      final status = await Permission.notification.request();
      if (!status.isGranted) {
        throw Exception('Notification permission denied');
      }

      final settings = await getSettings();
      final updatedSettings = settings.copyWith(
        pushNotificationsEnabled: true,
        notificationSettings: settings.notificationSettings?.copyWith(
              pushEnabled: true,
            ) ??
            const NotificationSettings(
              pushEnabled: true,
              emailEnabled: false,
              smsEnabled: false,
              enabledCategories: [],
              quietHours: TimeRange(
                startHour: 22,
                startMinute: 0,
                endHour: 8,
                endMinute: 0,
              ),
              vibrationEnabled: true,
              soundPreference: 'default',
            ),
      );

      await saveSettings(updatedSettings);
    } catch (e) {
      throw Exception('Failed to enable push notifications: $e');
    }
  }

  @override
  Future<void> disablePushNotifications() async {
    try {
      final settings = await getSettings();
      final updatedSettings = settings.copyWith(
        pushNotificationsEnabled: false,
        notificationSettings: settings.notificationSettings?.copyWith(
          pushEnabled: false,
        ),
      );

      await saveSettings(updatedSettings);
    } catch (e) {
      throw Exception('Failed to disable push notifications: $e');
    }
  }

  @override
  Future<void> enableEmailNotifications() async {
    try {
      final settings = await getSettings();
      final updatedSettings = settings.copyWith(
        emailNotificationsEnabled: true,
        notificationSettings: settings.notificationSettings?.copyWith(
              emailEnabled: true,
            ) ??
            const NotificationSettings(
              pushEnabled: false,
              emailEnabled: true,
              smsEnabled: false,
              enabledCategories: [],
              quietHours: TimeRange(
                startHour: 22,
                startMinute: 0,
                endHour: 8,
                endMinute: 0,
              ),
              vibrationEnabled: true,
              soundPreference: 'default',
            ),
      );

      await saveSettings(updatedSettings);
    } catch (e) {
      throw Exception('Failed to enable email notifications: $e');
    }
  }

  @override
  Future<void> disableEmailNotifications() async {
    try {
      final settings = await getSettings();
      final updatedSettings = settings.copyWith(
        emailNotificationsEnabled: false,
        notificationSettings: settings.notificationSettings?.copyWith(
          emailEnabled: false,
        ),
      );

      await saveSettings(updatedSettings);
    } catch (e) {
      throw Exception('Failed to disable email notifications: $e');
    }
  }

  // Security Methods
  @override
  Future<bool> isBiometricAvailable() async {
    try {
      final isAvailable = await _localAuth.canCheckBiometrics;
      if (!isAvailable) return false;

      final availableBiometrics = await _localAuth.getAvailableBiometrics();
      return availableBiometrics.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> authenticateWithBiometric() async {
    try {
      final isAvailable = await isBiometricAvailable();
      if (!isAvailable) return false;

      final didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to enable biometric login',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      return didAuthenticate;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> setBiometricEnabled(bool enabled) async {
    try {
      final settings = await getSettings();
      final updatedSettings = settings.copyWith(
        biometricEnabled: enabled,
        securitySettings: settings.securitySettings?.copyWith(
              biometricEnabled: enabled,
            ) ??
            SecuritySettings(
              biometricEnabled: enabled,
              twoFactorEnabled: false,
              sessionTimeout: 3600, // 1 hour
              autoLockEnabled: false,
              trustedDevices: [],
              loginNotificationsEnabled: true,
            ),
      );

      await saveSettings(updatedSettings);
    } catch (e) {
      throw Exception('Failed to update biometric settings: $e');
    }
  }

  @override
  Future<bool> is2FAEnabled() async {
    try {
      final settings = await getSettings();
      return settings.securitySettings?.twoFactorEnabled ?? false;
    } catch (e) {
      return false;
    }
  }

  // Data Management Methods
  @override
  Future<void> enableAutoBackup() async {
    try {
      final settings = await getSettings();
      final updatedSettings = settings.copyWith(
        autoBackup: true,
        dataSettings: settings.dataSettings?.copyWith(
              autoBackupEnabled: true,
            ) ??
            const DataSettings(
              autoBackupEnabled: true,
              dataSyncEnabled: false,
              backupFrequency: 'daily',
              syncedDataTypes: ['photos', 'documents'],
              maxStorageSize: 1073741824, // 1GB
              compressionEnabled: true,
              cloudProvider: 'default',
            ),
      );

      await saveSettings(updatedSettings);
    } catch (e) {
      throw Exception('Failed to enable auto backup: $e');
    }
  }

  @override
  Future<void> disableAutoBackup() async {
    try {
      final settings = await getSettings();
      final updatedSettings = settings.copyWith(
        autoBackup: false,
        dataSettings: settings.dataSettings?.copyWith(
          autoBackupEnabled: false,
        ),
      );

      await saveSettings(updatedSettings);
    } catch (e) {
      throw Exception('Failed to disable auto backup: $e');
    }
  }

  @override
  Future<void> enableDataSync() async {
    try {
      final settings = await getSettings();
      final updatedSettings = settings.copyWith(
        dataSync: true,
        dataSettings: settings.dataSettings?.copyWith(
              dataSyncEnabled: true,
            ) ??
            const DataSettings(
              autoBackupEnabled: false,
              dataSyncEnabled: true,
              backupFrequency: 'daily',
              syncedDataTypes: ['settings', 'preferences'],
              maxStorageSize: 1073741824, // 1GB
              compressionEnabled: true,
              cloudProvider: 'default',
            ),
      );

      await saveSettings(updatedSettings);
    } catch (e) {
      throw Exception('Failed to enable data sync: $e');
    }
  }

  @override
  Future<void> disableDataSync() async {
    try {
      final settings = await getSettings();
      final updatedSettings = settings.copyWith(
        dataSync: false,
        dataSettings: settings.dataSettings?.copyWith(
          dataSyncEnabled: false,
        ),
      );

      await saveSettings(updatedSettings);
    } catch (e) {
      throw Exception('Failed to disable data sync: $e');
    }
  }

  @override
  Future<StorageInfo> getStorageUsage() async {
    try {
      // In a real app, you'd calculate actual storage usage
      // For now, return mock data
      return const StorageInfo(
        photos: 512000000, // 512MB
        videos: 256000000, // 256MB
        documents: 64000000, // 64MB
        cache: 32000000, // 32MB
        total: 864000000, // 864MB
      );
    } catch (e) {
      throw Exception('Failed to get storage usage: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      // Clear application cache
      // This would involve clearing temporary files, image cache, etc.

      // Clear Playx cache if available
      await PlayxPrefs.clear();

      // You can add more cache clearing logic here
    } catch (e) {
      throw Exception('Failed to clear cache: $e');
    }
  }

  @override
  Future<String> exportData() async {
    try {
      final settings = await getSettings();

      // Create export data structure
      final exportData = {
        'settings': settings.toJson(),
        'exportedAt': DateTime.now().toIso8601String(),
        'version': '1.0',
      };

      return json.encode(exportData);
    } catch (e) {
      throw Exception('Failed to export data: $e');
    }
  }

  @override
  Future<void> importData(String data) async {
    try {
      final importData = json.decode(data) as Map<String, dynamic>;
      final settingsData = importData['settings'] as Map<String, dynamic>;

      final settings = Settings.fromJson(settingsData);
      await saveSettings(settings);
    } catch (e) {
      throw Exception('Failed to import data: $e');
    }
  }

  // Convenience methods for specific setting updates
  Future<NetworkResult<Settings>> toggleNotifications(
      String userId, bool enabled) async {
    try {
      final settings = await getSettings();
      final updatedSettings = settings.copyWith(
          pushNotificationsEnabled: enabled,
          notificationSettings:
              settings.notificationSettings?.copyWith(pushEnabled: enabled));
      await saveSettings(updatedSettings);
      return NetworkResult.success(updatedSettings);
    } catch (e) {
      return NetworkResult.error(
        UnexpectedErrorException(errorMessage: e.toString()),
      );
    }
  }

  Future<NetworkResult<Settings>> toggleBiometric(
      String userId, bool enabled) async {
    try {
      await setBiometricEnabled(enabled);
      final settings = await getSettings();
      return NetworkResult.success(settings);
    } catch (e) {
      return NetworkResult.error(
        UnexpectedErrorException(errorMessage: e.toString()),
      );
    }
  }

  Future<NetworkResult<Settings>> updateLanguage(
      String userId, String languageCode) async {
    try {
      final settings = await getSettings();
      final updatedSettings = settings.copyWith(languageCode: languageCode);
      await saveSettings(updatedSettings);
      return NetworkResult.success(updatedSettings);
    } catch (e) {
      return NetworkResult.error(
        UnexpectedErrorException(errorMessage: e.toString()),
      );
    }
  }

  Future<NetworkResult<Settings>> updateTheme(
      String userId, String themeId) async {
    try {
      final settings = await getSettings();
      final updatedSettings = settings.copyWith(themeId: themeId);
      await saveSettings(updatedSettings);
      return NetworkResult.success(updatedSettings);
    } catch (e) {
      return NetworkResult.error(
        UnexpectedErrorException(errorMessage: e.toString()),
      );
    }
  }

  // Network-based methods (maintain compatibility with existing code)
  Future<NetworkResult<Settings>> getUserSettings(String userId) async {
    try {
      final settings = await getSettings();
      return NetworkResult.success(settings);
    } catch (e) {
      return NetworkResult.error(
        UnexpectedErrorException(errorMessage: e.toString()),
      );
    }
  }

  Future<NetworkResult<Settings>> updateUserSettings(Settings settings) async {
    try {
      await saveSettings(settings);
      return NetworkResult.success(settings);
    } catch (e) {
      return NetworkResult.error(
        UnexpectedErrorException(errorMessage: e.toString()),
      );
    }
  }

  Future<NetworkResult<bool>> syncSettings(Settings settings) async {
    try {
      await saveSettings(settings);
      await syncSettingsToServer();
      return const NetworkResult.success(true);
    } catch (e) {
      return NetworkResult.error(
        UnexpectedErrorException(errorMessage: e.toString()),
      );
    }
  }

  Future<NetworkResult<Settings>> resetSettingsNetwork(String userId) async {
    try {
      await resetSettings();
      final settings = await getSettings();
      return NetworkResult.success(settings);
    } catch (e) {
      return NetworkResult.error(
        UnexpectedErrorException(errorMessage: e.toString()),
      );
    }
  }
}
