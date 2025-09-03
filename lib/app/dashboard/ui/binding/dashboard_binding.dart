part of '../imports/dashboard_imports.dart';

class DashboardBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    final repository = WishlistRepository.instance;
    Get.put(DashboardController(wishlistRepository: repository));
  }

  @override
  Future<void> onExit(
    BuildContext context,
  ) async {
    Get.delete<DashboardController>();
  }
}
