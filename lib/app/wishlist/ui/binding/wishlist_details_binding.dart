part of '../imports/wishlist_imports.dart';

class WishlistDetailsBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    Fimber.d('PlayxRoute Binding Wishlist Details onEnter');

    if (!Get.isRegistered<WishlistController>()) {
      Get.put(WishlistController());
    }
  }

  @override
  Future<void> onExit(BuildContext context, GoRouterState state) async {
    Fimber.d('PlayxRoute Binding Wishlist Details onExit');

    // if (Get.isRegistered<WishlistController>()) {
    //   Get.delete<WishlistController>();
    // }
  }
}
