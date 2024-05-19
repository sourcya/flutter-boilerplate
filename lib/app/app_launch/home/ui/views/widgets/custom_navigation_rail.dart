import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/navigation/go_router/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:playx/playx.dart';

import '../../../../../../core/resources/translation/app_translations.dart';

class CustomNavigationRail extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const CustomNavigationRail({required this.navigationShell, super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: (index) {
        AppRouter.goToBranch(index: index, navigationShell: navigationShell);
      },
      labelType: NavigationRailLabelType.all,
      destinations: [
        NavigationRailDestination(
          icon: const Icon(Icons.home),
          label: Text(AppTrans.dashboard.tr(context: context)),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.favorite_border),
          label: Text(AppTrans.wishlist.tr(context: context)),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.settings),
          label: Text(AppTrans.settings.tr(context: context)),
        ),
      ],
    );
  }
}
