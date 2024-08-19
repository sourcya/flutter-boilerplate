part of '../imports/dashboard_imports.dart';

class DashboardBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    Fimber.d('PlayxRoute Binding Dashboard onEnter');
    Get.put(DashboardController());
  }

  @override
  Future<void> onExit(
    BuildContext context,
  ) async {
    Fimber.d('PlayxRoute Binding Dashboard onExit');
    Get.delete<DashboardController>();
  }
}
