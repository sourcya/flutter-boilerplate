import 'dart:math';

import 'package:flutter_boilerplate/core/resources/dimens/mobile_dimens.dart';
import 'package:flutter_boilerplate/core/resources/dimens/small_mobile_dimens.dart';
import 'package:flutter_boilerplate/core/resources/dimens/tablet_dimens.dart';
import 'package:playx/playx.dart';

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
