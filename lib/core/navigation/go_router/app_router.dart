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

  /// Navigate to the current location of the branch at the provided index when
  /// tapping an item in the BottomNavigationBar.
  static void goToBranch({
    required int index,
    required StatefulNavigationShell navigationShell,
    bool initialLocation = true,
  }) {
    // When navigating to a new branch, it's recommended to use the goBranch
    // method, as doing so makes sure the last navigation state of the
    // Navigator for the branch is restored.
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex && initialLocation,
    );
  }

  static Future<void> offAllNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) async {
    return router.goNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
    );
  }

  static Future<void> offAndToNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) async {
    return router.goNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
    );
  }

  static Future<void> toNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) async {
    await router.pushNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
    );
  }

  static void pop() {
    return router.pop();
  }
}
