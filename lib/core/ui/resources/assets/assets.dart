part of '../../ui.dart';

///This class is responsible for providing asset's items paths.
abstract class Assets {
  Assets._();

  static Animations get animations => Animations();

  static Images get images => Images();

  static asset.Icons get icons => asset.Icons();
}
