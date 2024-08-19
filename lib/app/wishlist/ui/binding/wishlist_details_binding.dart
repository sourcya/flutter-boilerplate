part of '../imports/wishlist_imports.dart';

class WishlistDetailsBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    if (!Get.isRegistered<WishlistController>()) {
      Get.put(WishlistController());
    }
  }

  @override
  Future<void> onExit(
    BuildContext context,
  ) async {
    if (Get.isRegistered<WishlistController>()) {
      Get.delete<WishlistController>();
    }
  }
}
