import 'dart:io' show Directory;

import 'package:flutter/foundation.dart';
import 'package:flutter_boilerplate/app/wishlist/data/datasource/db/dao/wishlist_dao.dart';
import 'package:flutter_boilerplate/app/wishlist/data/datasource/db/local_wishlist_data_source.dart';
import 'package:flutter_boilerplate/app/wishlist/data/model/db/database_wishlist_item.dart';
import 'package:flutter_boilerplate/core/database/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:playx/playx.dart' show getIt;

class AppDatabase {
  /// The Store of this app.
  late final Store store;

  AppDatabase._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<AppDatabase> create() async {
    try {
      final docsDir = await getApplicationDocumentsDirectory();
      final dbPath = p.join(docsDir.path, "app_database");

      // Try to open the store with error handling
      final store = await openStore(directory: dbPath);
      
      return AppDatabase._create(store);
    } catch (e) {
      if (e.toString().contains('incompatible')) {
        // Handle version incompatibility by deleting old database
        final docsDir = await getApplicationDocumentsDirectory();
        final dbPath = p.join(docsDir.path, "app_database");
        
        // Delete the old database directory
        final dir = Directory(dbPath);
        if (await dir.exists()) {
          await dir.delete(recursive: true);
        }
        
        // Create a new store
        final store = await openStore(directory: dbPath);
        return AppDatabase._create(store);
      }
      rethrow;
    }
  }

  //web app (Data Browser)
  late final Admin admin;
  void runTestWebApp() {
    if (Admin.isAvailable()) {
      admin = Admin(store);
    }
  }

  void close() {
    store.close();
    if (Admin.isAvailable()) {
      admin.close();
    }
  }

  //wishlist box
  late final _wishlistBox = store.box<DatabaseWishlistItem>();

  late final wishlistDao = WishlistDao(box: _wishlistBox);

  static Future<void> init() async {

    final database = await AppDatabase.create();

    if (kDebugMode) {
      database.runTestWebApp();
    }

    final localWishlistDataSource =
        LocalWishlistDataSource(wishlistDao: database.wishlistDao);
    getIt.registerSingleton<AppDatabase>(database);
    getIt.registerSingleton<LocalWishlistDataSource>(localWishlistDataSource);
  }
}
