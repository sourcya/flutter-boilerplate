import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/widgets/components/custom_text.dart';
import 'package:playx/playx.dart';

import '../../../../../../core/resources/colors/app_colors.dart';
import '../../../../../../core/resources/translation/app_locale_config.dart';
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
              child: CustomText(
                'Sourcya',
                font: fontFamily,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            NavigationDrawerDestination(
              icon: const Icon(Icons.home),
              label: CustomText(AppTrans.dashboard.tr),
            ),
            NavigationDrawerDestination(
              icon: const Icon(Icons.favorite_border),
              label: CustomText(AppTrans.wishlist.tr),
            ),
            NavigationDrawerDestination(
              icon: const Icon(Icons.settings),
              label: CustomText(AppTrans.settings.tr),
            ),
            Divider(
              color: colorScheme.onSurface.withOpacity(.3),
            ),
            NavigationDrawerDestination(
              icon: const Icon(Icons.logout),
              label: CustomText(AppTrans.logout.tr),
            ),
          ],
        );
      },
    );
  }
}
