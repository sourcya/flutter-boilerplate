import 'package:flutter_boilerplate/app/wishlist/data/model/db/database_wishlist_item.dart';

import 'dao/wishlist_dao.dart';

class LocalWishlistDataSource {
  final WishlistDao wishlistDao;

  const LocalWishlistDataSource({required this.wishlistDao});

  Future<List<DatabaseWishlistItem>> getAllWishlistItems() {
    return wishlistDao.getAllWishlistItems();
  }

  Stream<List<DatabaseWishlistItem>> watchAllWishlistItems() {
    return wishlistDao.watchAllWishlistItems();
  }

  Future<int> insertWishlistItem(DatabaseWishlistItem wishlist) {
    return wishlistDao.insertWishlistItem(wishlist);
  }

  Future<List<int>> insertWishlistItems(
    List<DatabaseWishlistItem> wishlistItems,
  ) {
    return wishlistDao.insertWishlistItems(wishlistItems);
  }

  Future<bool> deleteWishlistItem(DatabaseWishlistItem wishlist) {
    return wishlistDao.deleteWishlistItem(wishlist);
  }

  Future<int> deleteAllWishlistItems() {
    return wishlistDao.deleteAllWishlistItems();
  }
}
