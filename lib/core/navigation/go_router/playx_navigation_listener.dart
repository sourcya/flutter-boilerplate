import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/navigation/go_router/app_router.dart';
import 'package:flutter_boilerplate/core/navigation/go_router/playx_route.dart';
import 'package:go_router/go_router.dart';

class PlayxNavigationListener extends StatefulWidget {
  final Widget Function(BuildContext context) builder;

  const PlayxNavigationListener({super.key, required this.builder});

  @override
  _PlayxNavigationListenerState createState() =>
      _PlayxNavigationListenerState();
}

class _PlayxNavigationListenerState extends State<PlayxNavigationListener> {
  RouteMatch? _currentRoute;

  @override
  void initState() {
    super.initState();
    AppRouter.addRouteChangeListener(listenToRouteChanges);
  }

  // Listen to route changes here
  void listenToRouteChanges() {
    final currentRoute = AppRouter.currentRoute;

    final previousRoute = _currentRoute?.route;
    if (previousRoute is PlayxRoute) {
      if (previousRoute.binding != null &&
          previousRoute.binding!.shouldExecuteOnExit) {
        previousRoute.binding!.onExit(
          context,
        );
      }
    }

    _currentRoute = currentRoute;
  }

  @override
  void dispose() {
    AppRouter.removeRouteChangeListener(listenToRouteChanges);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: widget.builder);
  }
}
