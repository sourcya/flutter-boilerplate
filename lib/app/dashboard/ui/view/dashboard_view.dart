part of '../imports/dashboard_imports.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: AppTrans.dashboard.tr),
      body:  OptimizedScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppTrans.dashboard.tr),
          ],
        ),
      ),
    );
  }

}
