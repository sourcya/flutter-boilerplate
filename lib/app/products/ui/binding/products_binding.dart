part of '../imports/products_imports.dart';

class ProductsBinding extends PlayxBinding {
  @override
  Future<void> onInitApp() async {
    ProductsRepository.registerInstance();
  }

  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    if (Get.isRegistered<ProductsController>()) {
      Get.delete<ProductsController>();
    }
    Get.put<ProductsController>(ProductsController());
  }

  @override
  Future<void> onReEnter(
    BuildContext context,
    GoRouterState? state,
    bool wasPoppedAndReentered,
  ) async {
    if (!Get.isRegistered<ProductsController>()) return;
    final controller = Get.find<ProductsController>();
    if (wasPoppedAndReentered) controller.refreshData();
  }

  @override
  Future<void> onExit(BuildContext context) async {
    Get.delete<ProductsController>();
  }
}
