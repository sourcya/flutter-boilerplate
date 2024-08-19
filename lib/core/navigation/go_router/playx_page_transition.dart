import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum PlayxPageTransition {
  none,
  material,
  cupertino,
  native,
  custom,
  fade;

  Page<T> buildPage<T>({
    required PlayxPageConfiguration config,
    required Widget child,
    required GoRouterState state,
  }) {
    switch (this) {
      case PlayxPageTransition.material:
        return MaterialPage(
          child: child,
          key: config.key ?? state.pageKey,
          name: config.name ?? state.name,
          arguments: config.arguments,
          fullscreenDialog: config.fullscreenDialog,
          maintainState: config.maintainState,
          restorationId: config.restorationId,
          canPop: config.canPop,
          onPopInvoked: config.onPopInvoked,
        );
      case PlayxPageTransition.cupertino:
        return CupertinoPage(
          child: child,
          key: config.key ?? state.pageKey,
          name: config.name ?? state.name,
          arguments: config.arguments,
          fullscreenDialog: config.fullscreenDialog,
          maintainState: config.maintainState,
          restorationId: config.restorationId,
          canPop: config.canPop,
          onPopInvoked: config.onPopInvoked,
        );
      case PlayxPageTransition.native:
        return !kIsWeb &&
                (defaultTargetPlatform == TargetPlatform.iOS ||
                    defaultTargetPlatform == TargetPlatform.macOS)
            ? CupertinoPage(
                child: child,
                key: config.key ?? state.pageKey,
                name: config.name ?? state.name,
                arguments: config.arguments,
                fullscreenDialog: config.fullscreenDialog,
                maintainState: config.maintainState,
                restorationId: config.restorationId,
                canPop: config.canPop,
                onPopInvoked: config.onPopInvoked,
              )
            : MaterialPage(
                child: child,
                key: config.key ?? state.pageKey,
                name: config.name ?? state.name,
                arguments: config.arguments,
                fullscreenDialog: config.fullscreenDialog,
                maintainState: config.maintainState,
                restorationId: config.restorationId,
                canPop: config.canPop,
                onPopInvoked: config.onPopInvoked,
              );
      case PlayxPageTransition.custom:
        return CustomTransitionPage(
          child: child,
          key: config.key ?? state.pageKey,
          name: config.name ?? state.name,
          arguments: config.arguments,
          fullscreenDialog: config.fullscreenDialog,
          maintainState: config.maintainState,
          restorationId: config.restorationId,
          transitionsBuilder: config.transitionsBuilder,
          transitionDuration: config.transitionDuration,
          reverseTransitionDuration: config.reverseTransitionDuration,
          opaque: config.opaque,
          barrierDismissible: config.barrierDismissible,
          barrierColor: config.barrierColor,
          barrierLabel: config.barrierLabel,
        );
      case PlayxPageTransition.fade:
        return CustomTransitionPage(
          child: child,
          key: config.key ?? state.pageKey,
          name: config.name ?? state.name,
          arguments: config.arguments,
          fullscreenDialog: config.fullscreenDialog,
          maintainState: config.maintainState,
          restorationId: config.restorationId,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
          transitionDuration: config.transitionDuration,
          reverseTransitionDuration: config.reverseTransitionDuration,
          opaque: config.opaque,
          barrierDismissible: config.barrierDismissible,
          barrierColor: config.barrierColor,
          barrierLabel: config.barrierLabel,
        );
      case PlayxPageTransition.none:
        return NoTransitionPage(
          child: child,
          key: config.key ?? state.pageKey,
          name: config.name ?? state.name,
          arguments: config.arguments,
          restorationId: config.restorationId,
        );
    }
  }
}

class PlayxPageConfiguration<T> {
  /// A duration argument to customize the duration of the custom page
  /// transition.
  ///
  /// Defaults to 300ms.
  final Duration transitionDuration;

  /// A duration argument to customize the duration of the custom page
  /// transition on pop.
  ///
  /// Defaults to 300ms.
  final Duration reverseTransitionDuration;

  /// Whether the route should remain in memory when it is inactive.
  ///
  /// If this is true, then the route is maintained, so that any futures it is
  /// holding from the next route will properly resolve when the next route
  /// pops. If this is not necessary, this can be set to false to allow the
  /// framework to entirely discard the route's widget hierarchy when it is
  /// not visible.
  final bool maintainState;

  /// Whether this page route is a full-screen dialog.
  ///
  /// In Material and Cupertino, being fullscreen has the effects of making the
  /// app bars have a close button instead of a back button. On iOS, dialogs
  /// transitions animate differently and are also not closeable with the
  /// back swipe gesture.
  final bool fullscreenDialog;

  /// Whether the route obscures previous routes when the transition is
  /// complete.
  ///
  /// When an opaque route's entrance transition is complete, the routes
  /// behind the opaque route will not be built to save resources.
  final bool opaque;

  /// Whether you can dismiss this route by tapping the modal barrier.
  final bool barrierDismissible;

  /// The color to use for the modal barrier.
  ///
  /// If this is null, the barrier will be transparent.
  final Color? barrierColor;

  /// The semantic label used for a dismissible barrier.
  ///
  /// If the barrier is dismissible, this label will be read out if
  /// accessibility tools (like VoiceOver on iOS) focus on the barrier.
  final String? barrierLabel;

  /// Override this method to wrap the child with one or more transition
  /// widgets that define how the route arrives on and leaves the screen.
  ///
  /// By default, the child (which contains the widget returned by buildPage) is
  /// not wrapped in any transition widgets.
  ///
  /// The transitionsBuilder method, is called each time the Route's state
  /// changes while it is visible (e.g. if the value of canPop changes on the
  /// active route).
  ///
  /// The transitionsBuilder method is typically used to define transitions
  /// that animate the new topmost route's comings and goings. When the
  /// Navigator pushes a route on the top of its stack, the new route's
  /// primary animation runs from 0.0 to 1.0. When the Navigator pops the
  /// topmost route, e.g. because the use pressed the back button, the primary
  /// animation runs from 1.0 to 0.0.
  final Widget Function(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) transitionsBuilder;

  /// The name of the route (e.g., "/settings").
  ///
  /// If null, the route is anonymous.
  final String? name;

  /// The arguments passed to this route.
  ///
  /// May be used when building the route, e.g. in [Navigator.onGenerateRoute].
  final Object? arguments;

  /// {@macro flutter.widgets.TransitionRoute.allowSnapshotting}
  final bool allowSnapshotting;

  /// The key associated with this page.
  ///
  /// This key will be used for comparing pages in [canUpdate].
  final LocalKey? key;

  /// Restoration ID to save and restore the state of the [Route] configured by
  /// this page.
  ///
  /// If no restoration ID is provided, the [Route] will not restore its state.
  ///
  /// See also:
  ///
  ///  * [RestorationManager], which explains how state restoration works in
  ///    Flutter.
  final String? restorationId;

  /// Called after a pop on the associated route was handled.
  ///
  /// It's not possible to prevent the pop from happening at the time that this
  /// method is called; the pop has already happened. Use [canPop] to
  /// disable pops in advance.
  ///
  /// This will still be called even when the pop is canceled. A pop is canceled
  /// when the associated [Route.popDisposition] returns false, or when
  /// [canPop] is set to false. The `didPop` parameter indicates whether or not
  /// the back navigation actually happened successfully.
  final PopInvokedWithResultCallback<T> onPopInvoked;

  /// When false, blocks the associated route from being popped.
  ///
  /// If this is set to false for first page in the Navigator. It prevents
  /// Flutter app from exiting.
  ///
  /// If there are any [PopScope] widgets in a route's widget subtree,
  /// each of their `canPop` must be `true`, in addition to this canPop, in
  /// order for the route to be able to pop.
  final bool canPop;

  const PlayxPageConfiguration({
    this.key,
    this.name,
    this.arguments,
    this.restorationId,
    this.maintainState = true,
    this.fullscreenDialog = false,
    this.allowSnapshotting = true,
    this.canPop = true,
    this.onPopInvoked = _defaultPopInvokedHandler,
  })  : transitionDuration = const Duration(milliseconds: 300),
        reverseTransitionDuration = const Duration(milliseconds: 300),
        opaque = true,
        barrierDismissible = false,
        barrierColor = null,
        barrierLabel = null,
        transitionsBuilder = _defaultTransition;

  const PlayxPageConfiguration.customTransition({
    required this.transitionsBuilder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.reverseTransitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.key,
    this.name,
    this.arguments,
    this.restorationId,
    this.maintainState = true,
    this.fullscreenDialog = false,
    this.allowSnapshotting = true,
    this.canPop = true,
    this.onPopInvoked = _defaultPopInvokedHandler,
  });

  static void _defaultPopInvokedHandler(bool didPop, Object? result) {}

  static Widget _defaultTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
