import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:playx/playx.dart';

import '../../app/wishlist/data/datasource/db/local_wishlist_data_source.dart';
import '../database/app_database.dart';
import '../network/api_client.dart';
import '../preferences/env_manger.dart';
import '../preferences/preference_manger.dart';
import '../widgets/navigation/bottom_nav/bottom_navigation/ui/imports/bottom_navigation_imports.dart';
import '../widgets/navigation/navigation_drawer/ui/imports/custom_navigation_drawer_imports.dart';

/// This class contains app configuration like playx configuration.
class AppConfig extends PlayXAppConfig {
  // setup and boot your dependencies here
  @override
  Future<void> boot() async {
    //USED FOR DEBUGGING
    WidgetsFlutterBinding.ensureInitialized();
    Fimber.plantTree(DebugTree());
    Get.put<MyPreferenceManger>(MyPreferenceManger());
    Get.put<EnvManger>(EnvManger());
    final PlayxNetworkClient client = await ApiClient.createApiClient();
    Get.put<PlayxNetworkClient>(client);

    final database = await AppDatabase.create();

    if (kDebugMode) {
      database.runTestWebApp();
    }

    final localWishlistDataSource =
        LocalWishlistDataSource(wishlistDao: database.wishlistDao);
    Get.put<AppDatabase>(database);
    Get.put<LocalWishlistDataSource>(localWishlistDataSource);
    Get.put<CustomNavigationDrawerController>(
      CustomNavigationDrawerController(),
    );
    Get.put<CustomBottomNavigationController>(
      CustomBottomNavigationController(),
    );
  }

  @override
  Future<void> asyncBoot() async {}
}
