import 'package:flutter/widgets.dart';
import 'package:flutter_boilerplate/core/navigation/go_router/playx_binding.dart';
import 'package:go_router/go_router.dart';
import 'package:playx/playx.dart';

import 'playx_page_transition.dart';

class PlayxRoute extends GoRoute {
  final PlayxBinding? binding;
  final PlayxPageTransition transition;
  final PlayxPageConfiguration pageConfiguration;

  PlayxRoute({
    required super.path,
    super.name,

    /// A custom builder for this route.
    ///
    /// For example:
    /// ```
    /// GoRoute(
    ///   path: '/',
    ///   builder: (BuildContext context, GoRouterState state) => FamilyPage(
    ///     families: Families.family(
    ///       state.pathParameters['id'],
    ///     ),
    ///   ),
    /// ),
    /// ```
    ///
    required GoRouterWidgetBuilder builder,
    this.transition = PlayxPageTransition.cupertino,
    this.pageConfiguration = const PlayxPageConfiguration(),
    super.parentNavigatorKey,
    this.binding,
    GoRouterRedirect? redirect,
    ExitCallback? onExit,
    super.routes = const <RouteBase>[],
  }) : super(
          redirect: (context, state) async {
            // Handle custom redirection logic if provided
            if (redirect != null) {
              return redirect(context, state);
            }
            final topRoute = state.topRoute;

            Fimber.d(
              'PlayxRoute : Redirecting to ${state.name} => ${state.fullPath}',
            );

            // Trigger onEnter when entering the page for the first time and when the top route is the same as the current route
            if (topRoute == null || name == topRoute.name) {
              binding?.onEnter(context, state);
            } else {}
            return null;
          },
          onExit: binding == null
              ? null
              : (context, state) async {
                  Fimber.d(
                    'PlayxRoute : onExit ${state.name} : state top ${state.topRoute?.name}',
                  );

                  binding.onExit(context, state);
                  if (onExit != null) {
                    return onExit(context, state);
                  }
                  return true;
                },
          pageBuilder: (ctx, state) {
            final Widget child;
            child = builder(ctx, state);
            return transition.buildPage(
                config: pageConfiguration, child: child, state: state);
          },
        );
}
