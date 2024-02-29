import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../resources/colors/app_colors.dart';
import '../resources/translation/app_locale_config.dart';

PlatformAppBar buildAppBar({required String title}) {
  return PlatformAppBar(
    // toolbarHeight: dimens.appBarHeight,
    title: Text(
      title,
      style: TextStyle(color: colorScheme.onBackground, fontFamily: fontFamily),
    ),
    material: (ctx, _) => MaterialAppBarData(
      centerTitle: true,
    ),
    cupertino: (_, __) => CupertinoNavigationBarData(
      // Issue with cupertino where a bar with no transparency
      // will push the list down. Adding some alpha value fixes it (in a hacky way)
      backgroundColor: colorScheme.background.withAlpha(254),
    ),
  );
}
