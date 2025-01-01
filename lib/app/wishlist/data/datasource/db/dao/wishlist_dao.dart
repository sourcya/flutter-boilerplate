import 'package:flutter_boilerplate/app/wishlist/data/model/db/database_wishlist_item.dart';
import 'package:flutter_boilerplate/core/database/objectbox.g.dart';

class WishlistDao {
  final Box<DatabaseWishlistItem> box;

  const WishlistDao({required this.box});

  Future<List<DatabaseWishlistItem>> getAllWishlistItems() {
    return box.query().build().findAsync();
  }

  Stream<List<DatabaseWishlistItem>> watchAllWishlistItems() {
    return box
        .query()
        .watch(triggerImmediately: true)
        .asyncMap((query) => query.findAsync());
  }

  Future<int> insertWishlistItem(DatabaseWishlistItem wishlist) async {
    return box.putAsync(wishlist);
  }

  Future<List<int>> insertWishlistItems(
    List<DatabaseWishlistItem> wishlistItems,
  ) async {
    return box.putManyAsync(wishlistItems);
  }

  Future<bool> deleteWishlistItem(DatabaseWishlistItem wishlist) async {
    return box.remove(wishlist.id);
  }

  Future<int> deleteAllWishlistItems() async {
    return box.removeAllAsync();
  }
}
