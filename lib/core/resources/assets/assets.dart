import 'package:flutter_boilerplate/core/resources/assets/animation/animations.dart';
import 'package:flutter_boilerplate/core/resources/assets/icons/icons.dart';
import 'package:flutter_boilerplate/core/resources/assets/images/images.dart';

///This class is responsible for providing asset's items paths.
abstract class Assets {
  Assets._();

  static Animations get animations => Animations();

  static Images get images => Images();

  static Icons get icons => Icons();
}
