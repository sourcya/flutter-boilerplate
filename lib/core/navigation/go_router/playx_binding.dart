import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

abstract class PlayxBinding {
  Future<void> onEnter(BuildContext context, GoRouterState state);

  Future<void> onExit(BuildContext context);
}
