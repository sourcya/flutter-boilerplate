import 'package:flutter_boilerplate/app/wishlist/data/datasource/db/local_wishlist_data_source.dart';
import 'package:flutter_boilerplate/app/wishlist/data/model/mapper/database_wishlist_to_wishlist_item_mapper.dart';
import 'package:flutter_boilerplate/app/wishlist/data/model/ui/wishlist.dart';
import 'package:playx/playx.dart';

class WishlistRepository {
  static final WishlistRepository _instance = WishlistRepository._internal();

  factory WishlistRepository() {
    return _instance;
  }

  WishlistRepository._internal();

  final LocalWishlistDataSource _localWishlistDataSource =
      Get.find<LocalWishlistDataSource>();

  Future<List<WishlistItem>> getAllWishlistItems() async {
    final items = await _localWishlistDataSource.getAllWishlistItems();
    return items.map((e) => e.toWishlistItem()).toList();
  }

  Stream<List<WishlistItem>> watchAllWishlistItems() {
    return _localWishlistDataSource.watchAllWishlistItems().map(
          (event) => event.map((e) => e.toWishlistItem()).toList(),
        );
  }

  Future<int> insertWishlistItem(WishlistItem wishlist) {
    return _localWishlistDataSource
        .insertWishlistItem(wishlist.toDatabaseWishlistItem());
  }

  void deleteWishlistItem(WishlistItem wishlist) {
    _localWishlistDataSource
        .deleteWishlistItem(wishlist.toDatabaseWishlistItem());
  }
}
