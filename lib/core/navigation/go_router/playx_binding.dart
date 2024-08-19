import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

abstract class PlayxBinding {
  bool shouldExecuteOnExit = false;

  /// Called when the route is entered for the first time.
  Future<void> onEnter(BuildContext context, GoRouterState state);

  /// Called when the route is exited and removed from the stack.
  Future<void> onExit(
    BuildContext context,
  );
}
