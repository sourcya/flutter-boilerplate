part of '../imports/wishlist_imports.dart';

class WishlistBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    Fimber.d('PlayxRoute Binding Wishlist onEnter');
    if (!Get.isRegistered<WishlistController>()) {
      Get.put(WishlistController());
    } else {
      Get.find<WishlistController>().watchWishlistItems();
    }

    Fimber.d(
        'PlayxRoute Binding Wishlist onEnter :${Get.find<WishlistController>()}');
  }

  @override
  Future<void> onExit(
    BuildContext context,
  ) async {
    final isDeleted = await Get.delete<WishlistController>();
    Fimber.d('PlayxRoute Binding Wishlist onExit :$isDeleted');
  }
}
