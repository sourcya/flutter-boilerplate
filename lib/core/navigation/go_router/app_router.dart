import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_pages.dart';
import '../app_routes.dart';

abstract class AppRouter {
  AppRouter._();

  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static final dashboardNavigatorAKey =
      GlobalKey<NavigatorState>(debugLabel: 'shell Dashboard');

  static final router = GoRouter(
    initialLocation: Paths.splash,
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    routes: AppPages.routes,
  );


  static RouteMatch get currentRoute =>
      router.routerDelegate.currentConfiguration.last;

  static String? get currentRouteName => currentRoute.route.name;

  /// Navigate to the current location of the branch at the provided index when
  /// tapping an item in the BottomNavigationBar.
  static void goToBranch({
    required int index,
    required StatefulNavigationShell navigationShell,
  }) {
    // When navigating to a new branch, it's recommended to use the goBranch
    // method, as doing so makes sure the last navigation state of the
    // Navigator for the branch is restored.
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  static Future<void> offAllNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    return router.goNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  static Future<void> offAndToNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    return router.goNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  static Future<void> toNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    await router.pushNamed(name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra);
  }

  static void pop() {
    return router.pop();
  }
}
