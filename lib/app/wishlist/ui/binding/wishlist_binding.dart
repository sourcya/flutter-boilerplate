part of '../imports/wishlist_imports.dart';

class WishlistBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    final repository = WishlistRepository.instance;
    Get.put(WishlistController(repository: repository));
  }

  @override
  Future<void> onExit(
    BuildContext context,
  ) async {
    // Get.delete<WishlistController>();
  }
}
