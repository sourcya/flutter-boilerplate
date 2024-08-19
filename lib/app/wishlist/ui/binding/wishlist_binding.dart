part of '../imports/wishlist_imports.dart';

class WishlistBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    Get.put(WishlistController());
  }

  @override
  Future<void> onExit(
    BuildContext context,
  ) async {
    // Get.delete<WishlistController>();
  }
}
