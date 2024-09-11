import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/navigation/navigation_utils.dart';
import 'package:flutter_boilerplate/core/utils/app_utils.dart';
import 'package:playx/playx.dart';
import 'package:playx_navigation/playx_navigation.dart';

import '../resources/colors/app_colors.dart';
import 'components/custom_text.dart';

enum AppBarLeadingType {
  none,
  back,
  drawer,
  navigationRail,
  drawerOrRail;

  Widget buildWidget(BuildContext context) {
    switch (this) {
      case AppBarLeadingType.none:
        return const SizedBox.shrink();
      case AppBarLeadingType.back:
        return Builder(
          builder: (context) {
            return IconButton(
              icon: GetPlatform.isIOS && context.locale.languageCode == 'ar'
                  ? Transform(
                      transform: Matrix4.identity()..rotateZ(pi),
                      alignment: Alignment.center,
                      // Center point as half the size of the child
                      child: Icon(
                        GetPlatform.isIOS
                            ? CupertinoIcons.back
                            : Icons.arrow_back,
                        color: context.colors.primary,
                        textDirection:
                            GetPlatform.isIOS ? TextDirection.ltr : null,
                      ),
                    )
                  : Icon(
                      GetPlatform.isIOS
                          ? CupertinoIcons.back
                          : Icons.arrow_back,
                      color: context.colors.primary,
                    ),
              onPressed: () {
                PlayxNavigation.pop();
              },
            );
          },
        );
      case AppBarLeadingType.drawer:
        return IconButton(
          icon: Icon(
            Icons.menu,
            color: context.colors.onSurface,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      case AppBarLeadingType.drawerOrRail:
        return NavigationUtils.canShowDrawer
            ? IconButton(
                icon: Icon(
                  Icons.menu,
                  color: context.colors.onSurface,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              )
            : const SizedBox.shrink();
      case AppBarLeadingType.navigationRail:
        return const SizedBox.shrink();
    }
  }

  bool get canShowDrawer =>
      this == AppBarLeadingType.drawer ||
      (this == AppBarLeadingType.drawerOrRail && AppUtils.isMobile());

  bool get canShowBack => this == AppBarLeadingType.back;

  bool get canShowNavigationRail =>
      this == AppBarLeadingType.navigationRail ||
      (this == AppBarLeadingType.drawerOrRail && !AppUtils.isMobile());
}

PlatformAppBar buildAppBar({
  required String title,
  AppBarLeadingType leading = AppBarLeadingType.drawerOrRail,
  required BuildContext context,
}) {
  return PlatformAppBar(
    // toolbarHeight: dimens.appBarHeight,
    automaticallyImplyLeading: false,
    leading: leading.buildWidget(context),
    title: CustomText(
      title,
      fontSize: 16,
    ),
    material: (ctx, _) => MaterialAppBarData(
      centerTitle: true,
    ),
    cupertino: (ctx, __) => CupertinoNavigationBarData(
      // Issue with cupertino where a bar with no transparency
      // will push the list down. Adding some alpha value fixes it (in a hacky way)
      backgroundColor: ctx.colors.surface.withAlpha(254),
    ),
  );
}
