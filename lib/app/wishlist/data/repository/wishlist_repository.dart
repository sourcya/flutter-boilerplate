import 'package:flutter_boilerplate/app/wishlist/data/datasource/db/local_wishlist_data_source.dart';
import 'package:flutter_boilerplate/app/wishlist/data/model/mapper/database_wishlist_to_wishlist_item_mapper.dart';
import 'package:flutter_boilerplate/app/wishlist/data/model/ui/wishlist.dart';
import 'package:playx/playx.dart';

class WishlistRepository {
  final LocalWishlistDataSource _localDatasource;
  WishlistRepository({
    required LocalWishlistDataSource localDatasource,
  }) : _localDatasource = localDatasource;

  static WishlistRepository get instance => getIt.get<WishlistRepository>();

  Future<List<WishlistItem>> getAllWishlistItems() async {
    final items = await _localDatasource.getAllWishlistItems();
    return items.map((e) => e.toWishlistItem()).toList();
  }

  Stream<List<WishlistItem>> watchAllWishlistItems() {
    return _localDatasource.watchAllWishlistItems().map(
          (event) => event.map((e) => e.toWishlistItem()).toList(),
        );
  }

  Future<int> insertWishlistItem(WishlistItem wishlist) {
    return _localDatasource
        .insertWishlistItem(wishlist.toDatabaseWishlistItem());
  }

  void deleteWishlistItem(WishlistItem wishlist) {
    _localDatasource.deleteWishlistItem(wishlist.toDatabaseWishlistItem());
  }
}
