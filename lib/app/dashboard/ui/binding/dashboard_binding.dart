part of '../imports/dashboard_imports.dart';

class DashboardBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    Get.put(DashboardController());
  }

  @override
  Future<void> onExit(
    BuildContext context,
  ) async {
    // Get.delete<DashboardController>();
  }
}
