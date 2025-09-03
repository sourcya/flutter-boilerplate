import 'package:flutter/widgets.dart';
import 'package:flutter_boilerplate/app/app_launch/app/ui/imports/app_imports.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/data_sources/auth0_auth_data_source.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/data_sources/test_auth_data_source.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/repo/auth_repository.dart';
import 'package:flutter_boilerplate/app/dashboard/data/datasource/dashboard_datasource.dart';
import 'package:flutter_boilerplate/app/dashboard/data/repository/dashboard_repository.dart';
import 'package:flutter_boilerplate/app/wishlist/data/datasource/db/local_wishlist_data_source.dart';
import 'package:flutter_boilerplate/app/wishlist/data/repository/wishlist_repository.dart';
import 'package:flutter_boilerplate/core/database/app_database.dart';
import 'package:flutter_boilerplate/core/network/network.dart';
import 'package:flutter_boilerplate/core/preferences/env_manger.dart';
import 'package:flutter_boilerplate/core/preferences/preference_manger.dart';
import 'package:playx/playx.dart';

late PlayxBaseLogger myLogger;

/// This class contains app configuration like playx configuration.
class AppConfig extends PlayXAppConfig {
  // setup and boot your dependencies here
  @override
  Future<void> boot() async {
    //USED FOR DEBUGGING
    WidgetsFlutterBinding.ensureInitialized();

    myLogger = PlayxLogger.initLogger(name: 'MY APP');

    await AppDatabase.init();

    await bootDependencies();
  }

  Future<void> bootDependencies() async {
    getIt.registerSingleton<MyPreferenceManger>(MyPreferenceManger());
    getIt.registerSingleton<EnvManger>(EnvManger());
    await ApiClient.init();

    final apiClient = ApiClient.client;
    final remoteAuthDataSource = TestAuthDataSource(client: apiClient);
    final auth0DataSource = Auth0AuthDataSource(
      client: apiClient,
      auth0: ApiClient.auth0,
      auth0Web: ApiClient.auth0Web,
    );

    final authRepository = AuthRepository(
      remoteAuthDataSource: remoteAuthDataSource,
      auth0DataSource: auth0DataSource,
      preferenceManger: MyPreferenceManger.instance,
    );

    getIt.registerSingleton<AuthRepository>(authRepository);

    final DashboardDatasource dashboardDatasource = DashboardDatasource();
    final dashboardRepository = DashboardRepository(
      dataSource: dashboardDatasource,
    );
    getIt.registerSingleton<DashboardRepository>(dashboardRepository);

    final wishlistRepository = WishlistRepository(
      localDatasource: LocalWishlistDataSource.instance,
    );
    getIt.registerSingleton<WishlistRepository>(wishlistRepository);

    Get.put<AppController>(
      AppController(),
    );
  }

  @override
  Future<void> asyncBoot() async {}
}
