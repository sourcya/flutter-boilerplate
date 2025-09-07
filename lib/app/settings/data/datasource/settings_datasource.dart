import 'dart:convert' show json;

import 'package:flutter_boilerplate/app/settings/data/model/settings_model.dart';
import 'package:flutter_boilerplate/core/network/network.dart';
import 'package:flutter_boilerplate/core/preferences/preference_manger.dart'
    show MyPreferenceManger;
import 'package:playx/playx.dart';

abstract class SettingsDatasource {
  Future<NetworkResult<Settings>> getUserSettings(String userId);
  Future<NetworkResult<Settings>> updateUserSettings(Settings settings);
  Future<NetworkResult<bool>> syncSettings(Settings settings);
  Future<NetworkResult<Settings>> resetSettings(String userId);
}

class RemoteSettingsDatasource implements SettingsDatasource {
  final PlayxNetworkClient client;

  RemoteSettingsDatasource({required this.client});

  @override
  Future<NetworkResult<Settings>> getUserSettings(String userId) async {
    final result = await client.get<Settings>(
      '${Endpoints.settings}/$userId',
      fromJson: Settings.fromJson,
    );
    return result;
  }

  @override
  Future<NetworkResult<Settings>> updateUserSettings(Settings settings) async {
    final token = await MyPreferenceManger.instance.token;

    final result = await client.put<Settings>(
      Endpoints.settings,
      headers: {'Authorization': 'Bearer $token'},
      body: settings.toJson(),
      fromJson: Settings.fromJson,
    );
    return result;
  }

  @override
  Future<NetworkResult<bool>> syncSettings(Settings settings) async {
    final result = await client.post<dynamic>(
      Endpoints.syncSettings,
      body: settings.toJson(),
      fromJson: (json) => json,
    );
    return result.map(
      success: (data) => (data.data is Map
          ? NetworkResult.success(
              (data.data as Map<String, dynamic>)['success'] as bool? ?? false)
          : const NetworkResult.success(false)),
      error: (error) => const NetworkResult.error(
        UnexpectedErrorException(errorMessage: ""),
      ),
    );
  }

  @override
  Future<NetworkResult<Settings>> resetSettings(String userId) async {
    final result = await client.post<Settings>(
      Endpoints.resetSettings,
      body: {'userId': userId},
      fromJson: Settings.fromJson,
    );
    return result;
  }
}

class LocalSettingsDatasource implements SettingsDatasource {
  static const String _settingsKey = 'user_settings';

  @override
  Future<NetworkResult<Settings>> getUserSettings(String userId) async {
    try {
      final settingsJson = PlayxPrefs.getString(_settingsKey);

      if (settingsJson.isEmpty) {
        // Return default settings
        final defaultSettings = Settings(lastUpdated: DateTime.now());
        return NetworkResult.success(defaultSettings);
      }

      final settings = Settings.fromJson(json.decode(settingsJson));
      return NetworkResult.success(settings);
    } catch (e) {
      return NetworkResult.error(
        UnexpectedErrorException(
          errorMessage: 'Failed to load local settings $e',
        ),
      );
    }
  }

  @override
  Future<NetworkResult<Settings>> updateUserSettings(Settings settings) async {
    try {
      final updatedSettings = settings.copyWith(lastUpdated: DateTime.now());
      await PlayxPrefs.setString(
        _settingsKey,
        json.encode(updatedSettings.toJson()),
      );
      return NetworkResult.success(updatedSettings);
    } catch (e) {
      return NetworkResult.error(
        UnexpectedErrorException(
          errorMessage: 'Failed to save settings $e',
        ),
      );
    }
  }

  @override
  Future<NetworkResult<bool>> syncSettings(Settings settings) async {
    // For local datasource, sync is just a save operation
    final result = await updateUserSettings(settings);
    return result.map(
      success: (NetworkSuccess<Settings> data) =>
          const NetworkResult.success(true),
      error: (NetworkError<Settings> error) => const NetworkResult.error(
        UnexpectedErrorException(errorMessage: ""),
      ),
    );
  }

  @override
  Future<NetworkResult<Settings>> resetSettings(String userId) async {
    try {
      await PlayxPrefs.remove(_settingsKey);
      final defaultSettings = Settings(lastUpdated: DateTime.now());
      await PlayxPrefs.setString(
        _settingsKey,
        json.encode(defaultSettings.toJson()),
      );
      return NetworkResult.success(defaultSettings);
    } catch (e) {
      return NetworkResult.error(
        UnexpectedErrorException(
          errorMessage: 'Failed to reset settings $e',
        ),
      );
    }
  }
}

// Mock datasource for testing
class MockSettingsDatasource implements SettingsDatasource {
  static Settings? _cachedSettings;

  @override
  Future<NetworkResult<Settings>> getUserSettings(String userId) async {
    await Future.delayed(const Duration(seconds: 1));

    _cachedSettings ??= Settings(lastUpdated: DateTime.now());

    return NetworkResult.success(_cachedSettings!);
  }

  @override
  Future<NetworkResult<Settings>> updateUserSettings(Settings settings) async {
    await Future.delayed(const Duration(seconds: 1));
    _cachedSettings = settings.copyWith(lastUpdated: DateTime.now());
    return NetworkResult.success(_cachedSettings!);
  }

  @override
  Future<NetworkResult<bool>> syncSettings(Settings settings) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const NetworkResult.success(true);
  }

  @override
  Future<NetworkResult<Settings>> resetSettings(String userId) async {
    await Future.delayed(const Duration(seconds: 1));
    _cachedSettings = Settings(lastUpdated: DateTime.now());
    return NetworkResult.success(_cachedSettings!);
  }
}
