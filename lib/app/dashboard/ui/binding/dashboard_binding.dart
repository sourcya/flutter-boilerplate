part of '../imports/dashboard_imports.dart';

class DashboardBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    if (Get.isRegistered<DashboardController>()) {
      Get.delete<DashboardController>();
    }
    Get.put(
      DashboardController(repository: DashboardRepository.instance),
    );
  }

  @override
  Future<void> onExit(BuildContext context) async {
    Get.delete<DashboardController>();
  }
}
