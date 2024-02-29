part of '../imports/wishlist_imports.dart';

class WishlistBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    Fimber.d('WishlistBinding Dashboard onEnter');

    if (!Get.isRegistered<WishlistController>()) {
      Get.put(WishlistController());
    }
  }

  @override
  Future<void> onExit(BuildContext context) async {
    Fimber.d('WishlistBinding Dashboard onEnter');

    // if (Get.isRegistered<WishlistController>()) {
    //   Get.delete<WishlistController>();
    // }
  }
}
