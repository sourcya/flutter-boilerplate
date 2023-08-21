part of '../../../imports/home_imports.dart';

class BuildFirstTab extends StatelessWidget {

  const BuildFirstTab();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: AppNavigation.instance.firstTabNavigatorKey,
    initialRoute: Routes.DASHBOARD,
      observers: [GetObserver((_) {}, Get.routing)],
      onGenerateRoute: AppPages.onGenerateFirstRoute,
    );
  }

}
