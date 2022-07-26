import 'package:flutter/cupertino.dart';
import 'package:flutter_boilerplate/pages/home/home_page.dart';
import 'package:flutter_boilerplate/pages/splash/splash_page.dart';

/// contains the entire `App` routes
abstract class Routes {
  /// indecates which `Route`goes with which `Page`
  static final list = <String, WidgetBuilder>{
    home: (_) => const HomePage(),
    splash: (_) => const SplashPage(),
  };

  static const home = '/';
  static const splash = '/splash';
}
