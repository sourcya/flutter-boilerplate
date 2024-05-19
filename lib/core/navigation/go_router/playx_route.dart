import 'package:flutter_boilerplate/core/navigation/go_router/playx_binding.dart';
import 'package:go_router/go_router.dart';

class PlayxRoute extends GoRoute {
  final PlayxBinding? binding;

  PlayxRoute({
    required super.path,
    super.name,
    super.builder,
    super.pageBuilder,
    super.parentNavigatorKey,
    this.binding,
    GoRouterRedirect? redirect,
    ExitCallback? onExit,
    super.routes = const <RouteBase>[],
  }) : super(
          redirect: (context, state) async {
            binding?.onEnter(context, state);
            if (redirect != null) {
              return redirect(context, state);
            }
            return null;
          },
          onExit: binding == null
              ? null
              : (context, state) async {
                  binding.onExit(context);
                  if (onExit != null) {
                    return onExit(context, state);
                  }
                  return true;
                },
        );
}
