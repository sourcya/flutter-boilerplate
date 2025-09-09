part of '../imports/settings_imports.dart';

class SettingsBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    // Setup dependencies if not already registered
    if (!getIt.isRegistered<SettingsRepository>()) {
      _setupDependencies();
    }

    Get.put(
      SettingsController(
        settingsRepository: getIt.get<SettingsRepository>(),
        profileRepository: getIt.get<ProfileRepository>(),
      ),
    );
  }

  @override
  Future<void> onExit(BuildContext context) async {
    await Get.delete<SettingsController>();
  }

  void _setupDependencies() {
    // Register datasources
    getIt.registerLazySingleton<SettingsDatasource>(
      () => RemoteSettingsDatasource(
        client: getIt<PlayxNetworkClient>(),
      ),
      instanceName: 'remote',
    );

    getIt.registerLazySingleton<SettingsDatasource>(
      () => LocalSettingsDatasource(),
      instanceName: 'local',
    );

    // For development/testing
    // getIt.registerLazySingleton<SettingsDatasource>(
    //   () => MockSettingsDatasource(),
    //   instanceName: 'remote',
    // );

    // Register repository
    getIt.registerLazySingleton<SettingsRepository>(
      () => SettingsRepository(
        remoteDatasource: getIt<SettingsDatasource>(instanceName: 'remote'),
        localDatasource: getIt<SettingsDatasource>(instanceName: 'local'),
        // localAuth: getIt<LocalAuth>(),
      ),
    );
  }
}
