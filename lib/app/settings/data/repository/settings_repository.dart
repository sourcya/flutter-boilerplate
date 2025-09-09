part of '../../ui/imports/settings_imports.dart';

abstract class ISettingsRepository {
  const ISettingsRepository();

  Future<NetworkResult<Settings>> getSettings();
  Future<NetworkResult<void>> saveSettings(Settings settings);
  Future<NetworkResult<void>> resetSettings();
  Future<NetworkResult<void>> syncSettingsToServer();

  Future<NetworkResult<void>> enablePushNotifications();
  Future<NetworkResult<void>> disablePushNotifications();
  Future<NetworkResult<void>> enableEmailNotifications();
  Future<NetworkResult<void>> disableEmailNotifications();

  Future<NetworkResult<bool>> isBiometricAvailable();
  Future<NetworkResult<bool>> authenticateWithBiometric();
  Future<NetworkResult<void>> setBiometricEnabled(bool enabled);
  Future<NetworkResult<bool>> is2FAEnabled();

  Future<NetworkResult<void>> enableAutoBackup();
  Future<NetworkResult<void>> disableAutoBackup();
  Future<NetworkResult<void>> enableDataSync();
  Future<NetworkResult<void>> disableDataSync();
  Future<NetworkResult<StorageInfo>> getStorageUsage();
  Future<NetworkResult<void>> clearCache();
  Future<NetworkResult<String>> exportData();
  Future<NetworkResult<void>> importData(String data);
}

class SettingsRepository extends ISettingsRepository {
  final SettingsDatasource _remoteDatasource;
  final SettingsDatasource _localDatasource;
  final LocalAuthentication _localAuth;

  SettingsRepository({
    required SettingsDatasource remoteDatasource,
    required SettingsDatasource localDatasource,
    LocalAuthentication? localAuth,
  })  : _remoteDatasource = remoteDatasource,
        _localDatasource = localDatasource,
        _localAuth = localAuth ?? LocalAuthentication();

  static SettingsRepository get instance => getIt.get<SettingsRepository>();

  Future<String> _currentUserId() async {
    final user = await MyPreferenceManger.instance.getSavedUser();
    return (user?.id ?? '').toString();
  }

  @override
  Future<NetworkResult<Settings>> getSettings() async {
    final userId = await _currentUserId();
    final remoteResult = await _remoteDatasource.getUserSettings(userId);

    if (remoteResult is NetworkError<Settings>) {
      final localResult = await _localDatasource.getUserSettings(userId);
      if (localResult is NetworkError<Settings>) {
        final defaultSettings = Settings(
          pushNotificationsEnabled: false,
          emailNotificationsEnabled: false,
          biometricEnabled: false,
          autoBackup: false,
          dataSync: false,
          lastUpdated: DateTime.now(),
        );

        return NetworkResult<Settings>.success(defaultSettings);
      }

      return localResult;
    }

    return remoteResult;
  }

  @override
  Future<NetworkResult<void>> saveSettings(Settings settings) async {
    final localResult = await _localDatasource.updateUserSettings(settings);

    return localResult.mapDataAsyncInIsolate<void>(
      mapper: (_) async {
        final remoteResult =
            await _remoteDatasource.updateUserSettings(settings);
        return remoteResult.mapDataAsyncInIsolate<void>(
          mapper: (_) => const NetworkResult<void>.success(null),
        );
      },
    );
  }

  @override
  Future<NetworkResult<void>> resetSettings() async {
    final result =
        await _remoteDatasource.resetSettings(await _currentUserId());

    return result.mapDataAsyncInIsolate<void>(
      mapper: (_) async {
        await _localDatasource.resetSettings(await _currentUserId());
        return const NetworkResult<void>.success(null);
      },
    );
  }

  @override
  Future<NetworkResult<void>> syncSettingsToServer() async {
    final localResult =
        await _localDatasource.getUserSettings(await _currentUserId());

    return localResult.mapDataAsyncInIsolate<void>(
      mapper: (settings) async {
        final syncResult = await _remoteDatasource.syncSettings(settings);
        return syncResult.mapDataAsyncInIsolate<void>(
          mapper: (_) => const NetworkResult<void>.success(null),
        );
      },
    );
  }

  @override
  Future<NetworkResult<void>> enablePushNotifications() async {
    final status = await Permission.notification.request();
    if (!status.isGranted) {
      return const NetworkError(
        ApiException(errorMessage: 'Notification permission denied'),
      );
    }

    final settingsResult = await getSettings();
    return settingsResult.mapDataAsyncInIsolate<void>(
      mapper: (settings) {
        final updatedSettings = settings.copyWith(
          pushNotificationsEnabled: true,
          notificationSettings:
              settings.notificationSettings?.copyWith(pushEnabled: true) ??
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

        return saveSettings(updatedSettings);
      },
    );
  }

  @override
  Future<NetworkResult<void>> disablePushNotifications() async {
    final settingsResult = await getSettings();
    return settingsResult.mapDataAsyncInIsolate<void>(
      mapper: (settings) {
        final updatedSettings = settings.copyWith(
          pushNotificationsEnabled: false,
          notificationSettings: settings.notificationSettings?.copyWith(
            pushEnabled: false,
          ),
        );

        return saveSettings(updatedSettings);
      },
    );
  }

  @override
  Future<NetworkResult<void>> enableEmailNotifications() async {
    final settingsResult = await getSettings();
    return settingsResult.mapDataAsyncInIsolate<void>(
      mapper: (settings) {
        final updatedSettings = settings.copyWith(
          emailNotificationsEnabled: true,
          notificationSettings:
              settings.notificationSettings?.copyWith(emailEnabled: true) ??
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

        return saveSettings(updatedSettings);
      },
    );
  }

  @override
  Future<NetworkResult<void>> disableEmailNotifications() async {
    final settingsResult = await getSettings();
    return settingsResult.mapDataAsyncInIsolate<void>(
      mapper: (settings) {
        final updatedSettings = settings.copyWith(
          emailNotificationsEnabled: false,
          notificationSettings:
              settings.notificationSettings?.copyWith(emailEnabled: false),
        );

        return saveSettings(updatedSettings);
      },
    );
  }

  // Security Methods
  @override
  Future<NetworkResult<bool>> isBiometricAvailable() async {
    try {
      final isAvailable = await _localAuth.canCheckBiometrics;
      if (!isAvailable) return const NetworkResult.success(false);

      final availableBiometrics = await _localAuth.getAvailableBiometrics();
      return NetworkResult.success(availableBiometrics.isNotEmpty);
    } catch (e) {
      return NetworkResult.error(
        ApiException(errorMessage: "Failed to check biometrics $e"),
      );
    }
  }

  @override
  Future<NetworkResult<bool>> authenticateWithBiometric() async {
    try {
      final isAvailableResult = await isBiometricAvailable();

      return isAvailableResult.mapDataAsyncInIsolate<bool>(
        mapper: (isAvailable) async {
          if (!isAvailable) return const NetworkResult.success(false);

          final didAuthenticate = await _localAuth.authenticate(
            localizedReason: 'Please authenticate to enable biometric login',
            options: const AuthenticationOptions(
              biometricOnly: true,
              stickyAuth: true,
            ),
          );

          return NetworkResult.success(didAuthenticate);
        },
      );
    } catch (e) {
      return NetworkResult.error(
        ApiException(errorMessage: "Failed to authenticate with biometric $e"),
      );
    }
  }

  @override
  Future<NetworkResult<void>> setBiometricEnabled(bool enabled) async {
    final settingsResult = await getSettings();
    return settingsResult.mapDataAsyncInIsolate<void>(
      mapper: (settings) {
        final updatedSettings = settings.copyWith(
          biometricEnabled: enabled,
          securitySettings:
              settings.securitySettings?.copyWith(biometricEnabled: enabled) ??
                  SecuritySettings(
                    biometricEnabled: enabled,
                    twoFactorEnabled: false,
                    sessionTimeout: 3600,
                    autoLockEnabled: false,
                    trustedDevices: [],
                    loginNotificationsEnabled: true,
                  ),
        );

        return saveSettings(updatedSettings);
      },
    );
  }

  @override
  Future<NetworkResult<bool>> is2FAEnabled() async {
    final settingsResult = await getSettings();
    return settingsResult.mapDataAsyncInIsolate<bool>(
      mapper: (settings) => NetworkResult.success(
          settings.securitySettings?.twoFactorEnabled ?? false),
    );
  }

  // Data Management Methods
  @override
  Future<NetworkResult<void>> enableAutoBackup() async {
    final settingsResult = await getSettings();
    return settingsResult.mapDataAsyncInIsolate<void>(
      mapper: (settings) {
        final updatedSettings = settings.copyWith(
          autoBackup: true,
          dataSettings:
              settings.dataSettings?.copyWith(autoBackupEnabled: true) ??
                  const DataSettings(
                    autoBackupEnabled: true,
                    dataSyncEnabled: false,
                    backupFrequency: 'daily',
                    syncedDataTypes: ['photos', 'documents'],
                    maxStorageSize: 1073741824,
                    compressionEnabled: true,
                    cloudProvider: 'default',
                  ),
        );

        return saveSettings(updatedSettings);
      },
    );
  }

  @override
  Future<NetworkResult<void>> disableAutoBackup() async {
    final settingsResult = await getSettings();
    return settingsResult.mapDataAsyncInIsolate<void>(
      mapper: (settings) {
        final updatedSettings = settings.copyWith(
          autoBackup: false,
          dataSettings: settings.dataSettings?.copyWith(
            autoBackupEnabled: false,
          ),
        );

        return saveSettings(updatedSettings);
      },
    );
  }

  @override
  Future<NetworkResult<void>> enableDataSync() async {
    final settingsResult = await getSettings();
    return settingsResult.mapDataAsyncInIsolate<void>(
      mapper: (settings) {
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
                maxStorageSize: 1073741824,
                compressionEnabled: true,
                cloudProvider: 'default',
              ),
        );

        return saveSettings(updatedSettings);
      },
    );
  }

  @override
  Future<NetworkResult<void>> disableDataSync() async {
    final settingsResult = await getSettings();
    return settingsResult.mapDataAsyncInIsolate<void>(
      mapper: (settings) {
        final updatedSettings = settings.copyWith(
          dataSync: false,
          dataSettings: settings.dataSettings?.copyWith(dataSyncEnabled: false),
        );

        return saveSettings(updatedSettings);
      },
    );
  }

  @override
  Future<NetworkResult<StorageInfo>> getStorageUsage() async {
    try {
      // In a real app, you'd calculate actual storage usage
      return const NetworkResult.success(StorageInfo(
        photos: 512000000,
        videos: 256000000,
        documents: 64000000,
        cache: 32000000,
        total: 864000000,
      ));
    } catch (e) {
      return NetworkResult.error(
        ApiException(errorMessage: "Failed to get storage usage $e"),
      );
    }
  }

  @override
  Future<NetworkResult<void>> clearCache() async {
    try {
      await PlayxPrefs.clear();
      return const NetworkResult.success(null);
    } catch (e) {
      return NetworkResult.error(
        ApiException(errorMessage: "Failed to clear cache $e"),
      );
    }
  }

  @override
  Future<NetworkResult<String>> exportData() async {
    final settingsResult = await getSettings();
    return settingsResult.mapDataAsyncInIsolate<String>(
      mapper: (settings) {
        final exportData = {
          'settings': settings.toJson(),
          'exportedAt': DateTime.now().toIso8601String(),
          'version': '1.0',
        };

        return NetworkResult.success(json.encode(exportData));
      },
    );
  }

  @override
  Future<NetworkResult<void>> importData(String data) async {
    try {
      final importData = json.decode(data) as Map<String, dynamic>;
      final settingsData = importData['settings'] as Map<String, dynamic>;

      final settings = Settings.fromJson(settingsData);
      return saveSettings(settings);
    } catch (e) {
      return NetworkResult.error(
        ApiException(errorMessage: "Failed to import data $e"),
      );
    }
  }
}
