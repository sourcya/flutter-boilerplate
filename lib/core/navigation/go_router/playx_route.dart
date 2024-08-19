import 'package:flutter_boilerplate/core/navigation/go_router/playx_binding.dart';
import 'package:go_router/go_router.dart';

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
            // Trigger onEnter when entering the page for the first time and when the top route is the same as the current route
            if (topRoute == null || name == topRoute.name) {
              binding?.shouldExecuteOnExit = false;
              binding?.onEnter(context, state);
            } else {}
            return null;
          },
          onExit: binding == null
              ? onExit
              : (context, state) async {
                  if (onExit != null) {
                    return onExit(context, state);
                  }

                  binding.shouldExecuteOnExit = true;
                  return true;
                },
          pageBuilder: (ctx, state) {
            return transition.buildPage(
              config: pageConfiguration,
              child: builder(ctx, state),
              state: state,
            );
          },
        );
}
