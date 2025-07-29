import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boilerplate/app/app_launch/app/ui/imports/app_imports.dart';
import 'package:flutter_boilerplate/app/wishlist/data/datasource/db/local_wishlist_data_source.dart';
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

    Get.put<MyPreferenceManger>(MyPreferenceManger());
    Get.put<EnvManger>(EnvManger());
    ApiClient.init();

    final database = await AppDatabase.create();

    if (kDebugMode) {
      database.runTestWebApp();
    }

    final localWishlistDataSource =
        LocalWishlistDataSource(wishlistDao: database.wishlistDao);
    Get.put<AppDatabase>(database);
    Get.put<LocalWishlistDataSource>(localWishlistDataSource);
    Get.put<AppController>(
      AppController(),
    );
  }

  @override
  Future<void> asyncBoot() async {}
}
