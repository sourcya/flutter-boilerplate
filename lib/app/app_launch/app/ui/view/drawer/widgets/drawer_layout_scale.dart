part of '../../../imports/app_imports.dart';

/// Drawer / rail layouts use raw dp in landscape and [.r] / [.sp] in portrait.
@immutable
class DrawerScale {
  final bool isLandscape;

  const DrawerScale(this.isLandscape);

  factory DrawerScale.of(BuildContext context) => DrawerScale(context.isAppLandscape);

  double r(double value) => isLandscape ? value : value.r;

  double sp(double value) => isLandscape ? value : value.sp;

  /// Collapsed landscape rail: nav tiles, profile avatar, etc.
  double get railChromeBorderRadius => r(6);

  double get railChromeTileHeight => isLandscape ? 32.0 : r(32);
}
