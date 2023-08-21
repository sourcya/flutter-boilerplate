part of '../../../imports/home_imports.dart';

class BuildThirdTab extends StatelessWidget {

  const BuildThirdTab();

  @override
  Widget build(BuildContext context) {
      return Navigator(
          key: AppNavigation.instance.thirdTabNavigatorKey,
          initialRoute: Routes.SETTINGS,
          observers: [GetObserver((_) {}, Get.routing)],
          onGenerateRoute: AppPages.onGenerateThirdRoute,
      );
  }

}
