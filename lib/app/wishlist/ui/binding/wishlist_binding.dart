part of '../imports/wishlist_imports.dart';


class WishlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WishlistController>(
          () => WishlistController(),
    );
  }
}
