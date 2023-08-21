part of '../imports/dashboard_imports.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: buildAppBar(title: AppTrans.dashboard.tr),
      children: [
        Text(AppTrans.dashboard.tr),
      ],
    );
  }
}
