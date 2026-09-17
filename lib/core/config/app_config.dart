import 'package:flutter/widgets.dart';
import 'package:flutter_boilerplate/app/app_launch/app/ui/imports/app_imports.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/data_sources/test_auth_data_source.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/repo/auth_repository.dart';
import 'package:flutter_boilerplate/app/dashboard/data/datasource/dashboard_datasource.dart';
import 'package:flutter_boilerplate/app/dashboard/data/repository/dashboard_repository.dart';
import 'package:flutter_boilerplate/core/network/network.dart';
import 'package:flutter_boilerplate/core/preferences/env_manger.dart';
import 'package:flutter_boilerplate/core/preferences/preference_manger.dart';
import 'package:playx/playx.dart';

late PlayxBaseLogger myLogger;

/// This class contains app configuration like playx configuration.
class AppConfig extends PlayXAppConfig {
  @override
  Future<void> boot() async {
    WidgetsFlutterBinding.ensureInitialized();

    myLogger = PlayxLogger.initLogger(name: 'MY APP');

    await bootDependencies();
  }

  Future<void> bootDependencies() async {
    getIt.registerSingleton<MyPreferenceManger>(MyPreferenceManger());
    getIt.registerSingleton<EnvManger>(EnvManger());
    await ApiClient.init();

    final apiClient = ApiClient.client;
    // Extension point: swap [TestAuthDataSource] with [RemoteAuthDataSource]
    // to hit a real login endpoint via PlayxNetworkClient.
    final remoteAuthDataSource = TestAuthDataSource(client: apiClient);

    final authRepository = AuthRepository(
      remoteAuthDataSource: remoteAuthDataSource,
      preferenceManger: MyPreferenceManger.instance,
    );

    getIt.registerSingleton<AuthRepository>(authRepository);

    if (!getIt.isRegistered<DashboardDatasource>()) {
      getIt.registerLazySingleton<DashboardDatasource>(
        DashboardDatasourceImpl.new,
      );
    }
    if (!getIt.isRegistered<DashboardRepository>()) {
      getIt.registerLazySingleton<DashboardRepository>(
        () => DashboardRepository(
          dataSource: getIt.get<DashboardDatasource>(),
        ),
      );
    }

    // Note: Products is a route-scoped feature - its datasource/repository
    // are registered lazily by `ProductsBinding.onInitApp()`, not here. See
    // `.agent/skills/dependency-injection/SKILL.md`.

    Get.put<AppController>(
      AppController(),
    );
  }

  @override
  Future<void> asyncBoot() async {}
}
