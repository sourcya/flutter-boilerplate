import 'dart:math';

import 'package:playx/playx.dart';

import 'mobile_dimens.dart';
import 'small_mobile_dimens.dart';
import 'tablet_dimens.dart';

abstract class Dimens {
  double get dashboardLogoSize;

  double get drawerItemHorizontalMargin;

  double get drawerItemTileVerticalContentPadding;

  double get drawerItemIconBackgroundRadius;

  double get drawerItemIconSize;

  double get drawerItemTextSize;

  double get checkBoxScale;

  double get appBarHeight;

  double get appBarTextSize;

  static const bottomNavBarHeight = 56.0;

  static double fieldTextSize = 16.sp;
}

Dimens get dimens {
  final double width = ScreenUtil().screenWidth;
  final double height = ScreenUtil().screenHeight;

  final shortestSide = min(width.abs(), height.abs());

  final isTablet = shortestSide >= 600;
  final isSmallMobile = height <= 600;
  return isTablet
      ? TabletDimens()
      : isSmallMobile
          ? SmallMobileDimens()
          : MobileDimens();
}
