part of '../../ui.dart';

///This class is responsible for providing asset's items paths.
abstract class Assets {
  Assets._();

  static Animations get animations => Animations();

  static asset.Images get images => asset.Images();

  static asset.Icons get icons => asset.Icons();

  static asset.Logo get logos => asset.Logo();

}
