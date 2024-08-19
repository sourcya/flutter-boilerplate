part of '../imports/dashboard_imports.dart';

class DashboardBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    Fimber.d('PlayxRoute Binding Dashboard onEnter');
    if (!Get.isRegistered<DashboardController>()) {
      Get.put(DashboardController());
    }
  }

  @override
  Future<void> onExit(BuildContext context, GoRouterState state) async {
    Fimber.d('PlayxRoute Binding Dashboard onExit');
    // if (Get.isRegistered<DashboardController>()) {
    //   Fimber.d('PlayxBinding Dashboard onExit delete');
    //
    //   Get.delete<DashboardController>();
    // }
  }
}
