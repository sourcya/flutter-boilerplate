import 'package:flutter_boilerplate/app/wishlist/data/model/db/database_wishlist_item.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../app/wishlist/data/datasource/db/dao/wishlist_dao.dart';
import 'objectbox.g.dart';

class AppDatabase {
  /// The Store of this app.
  late final Store store;

  AppDatabase._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<AppDatabase> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(docsDir.path, "app_database");

    final store = Store.isOpen(dbPath)
        ? Store.attach(getObjectBoxModel(), dbPath)
        : await openStore(directory: dbPath);

    return AppDatabase._create(store);
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
  }

  //wishlist box
  late final _wishlistBox = store.box<DatabaseWishlistItem>();

  late final wishlistDao = WishlistDao(box: _wishlistBox);
}
