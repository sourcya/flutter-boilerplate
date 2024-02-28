import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:playx/playx.dart';

import '../../../../../../core/navigation/go_router/app_router.dart';
import '../../../../../../core/resources/colors/app_colors.dart';
import '../../../../../../core/resources/translation/app_locale_config.dart';
import '../../../../../../core/resources/translation/app_translations.dart';
import '../../../../../../core/widgets/components/custom_text.dart';

class CustomNavigationDrawer extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const CustomNavigationDrawer({required this.navigationShell, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NavigationDrawer(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          AppRouter.goToBranch(index: index, navigationShell: navigationShell);
        },
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
      ),
    );
  }
}
