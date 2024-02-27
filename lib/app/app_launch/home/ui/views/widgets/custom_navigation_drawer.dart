import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../../../../../../core/resources/colors/app_colors.dart';
import '../../../../../../core/resources/translation/app_translations.dart';
import '../../imports/home_imports.dart';

class CustomNavigationDrawer extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return NavigationDrawer(
          selectedIndex: controller.currentIndex.value,
          onDestinationSelected: controller.updatePage,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
              child: Text(
                'Sourcya',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            NavigationDrawerDestination(
              icon: const Icon(Icons.home),
              label: Text(AppTrans.dashboard.tr),
            ),
            NavigationDrawerDestination(
              icon: const Icon(Icons.favorite_border),
              label: Text(AppTrans.wishlist.tr),
            ),
            NavigationDrawerDestination(
              icon: const Icon(Icons.settings),
              label: Text(AppTrans.settings.tr),
            ),
            Divider(
              color: colorScheme.onSurface.withOpacity(.3),
            ),
            NavigationDrawerDestination(
              icon: const Icon(Icons.logout),
              label: Text(AppTrans.logout.tr),
            ),
          ],
        );
      },
    );
  }
}
