import 'package:flutter/foundation.dart';
import 'package:flutter_boilerplate/app/wishlist/data/datasource/db/local_wishlist_data_source.dart';
import 'package:playx/playx.dart';

import '../database/app_database.dart';
import '../network/api_client.dart';
import '../preferences/env_manger.dart';
import '../preferences/preference_manger.dart';

/// This class contains app configuration like playx configuration.
class AppConfig extends PlayXAppConfig {
  // setup and boot your dependencies here
  @override
  Future<void> boot() async {
    //USED FOR DEBUGGING
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
  }

  @override
  Future<void> asyncBoot() async {
    return Future.delayed(10.seconds);
  }
}
