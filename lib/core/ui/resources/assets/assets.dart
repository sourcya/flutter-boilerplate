part of '../../ui.dart';

///This class is responsible for providing asset's items paths.
abstract class Assets {
  Assets._();

  static Animations get animations => Animations();

  static Images get images => Images();

  static asset.Icons get icons => asset.Icons();

  static _Logos get logos => _Logos();
}

/// Typographic alias matching Madaan/TMT widget conventions (`Asset.icons.*`).
abstract final class Asset {
  const Asset._();

  static Animations get animations => Assets.animations;
  static Images get images => Assets.images;
  static asset.Icons get icons => Assets.icons;
  static _Logos get logos => Assets.logos;
}

class _Logos {
  String get logo => Assets.icons.logo;
  String get horizontal => Assets.icons.logo;

  String getHorizontalLogo(bool isDark) => horizontal;
}
