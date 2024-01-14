import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../../../../../../core/resources/translation/app_translations.dart';
import '../../imports/home_imports.dart';

class CustomNavigationRail extends GetView<HomeController>{
  @override
  Widget build(BuildContext context) {

    return  Obx(
          () {
        return NavigationRail(
          selectedIndex: controller.currentIndex.value,
          onDestinationSelected: controller.updatePage,
          labelType: NavigationRailLabelType.all,
          destinations: [
            NavigationRailDestination(
              icon: const Icon(Icons.home),
              label: Text(AppTrans.dashboard.tr),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.favorite_border),
              label: Text(AppTrans.wishlist.tr),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.settings),
              label: Text(AppTrans.settings.tr),
            ),
          ],
        );
      },
    );
  }
}
