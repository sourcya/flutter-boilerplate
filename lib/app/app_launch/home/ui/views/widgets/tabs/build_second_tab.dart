part of '../../../imports/home_imports.dart';

class BuildSecondTab extends StatelessWidget {

  const BuildSecondTab();

  @override
  Widget build(BuildContext context) {
      return Navigator(
          key: AppNavigation.instance.secondTabNavigatorKey,
          initialRoute: Routes.WISHLIST,
          observers: [GetObserver((_) {}, Get.routing)],
          onGenerateRoute: AppPages.onGenerateSecondRoute,
      );

  }

}
