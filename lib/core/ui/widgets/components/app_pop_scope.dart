part of '../../ui.dart';

class AppPopScope extends StatefulWidget {
  final Widget child;

  final PopInvokedWithResultCallback? onPopInvokedWithResult;

  final bool canPop;
  // Temporarily intercept the back button event processing.
  const AppPopScope({
    super.key,
    required this.child,
    this.canPop = true,
    this.onPopInvokedWithResult,
  });

  @override
  State<AppPopScope> createState() => _AppPopScopeState();
}

class _AppPopScopeState extends State<AppPopScope> {
  final bool _enable = PlayxPlatform.isAndroid;
  ModalRoute? _route;
  BackButtonDispatcher? _parentBackBtnDispatcher;
  ChildBackButtonDispatcher? _backBtnDispatcher;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _route = ModalRoute.of(context);
    _updateBackButtonDispatcher();
  }

  @override
  void activate() {
    super.activate();
    _updateBackButtonDispatcher();
  }

  @override
  void deactivate() {
    super.deactivate();
    _disposeBackBtnDispatcher();
  }

  @override
  void dispose() {
    _disposeBackBtnDispatcher();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.canPop,
      onPopInvokedWithResult: widget.onPopInvokedWithResult,
      child: widget.child,
    );
  }

  void _updateBackButtonDispatcher() {
    if (!_enable) return;

    var dispatcher = Router.maybeOf(context)?.backButtonDispatcher;
    if (dispatcher != _parentBackBtnDispatcher) {
      _disposeBackBtnDispatcher();
      _parentBackBtnDispatcher = dispatcher;
      if (dispatcher is BackButtonDispatcher && dispatcher is! ChildBackButtonDispatcher) {
        dispatcher = dispatcher.createChildBackButtonDispatcher();
      }
      _backBtnDispatcher = dispatcher! as ChildBackButtonDispatcher;
    }
    _backBtnDispatcher?.removeCallback(_handleBackButton);
    _backBtnDispatcher?.addCallback(_handleBackButton);
    _backBtnDispatcher?.takePriority();
  }

  void _disposeBackBtnDispatcher() {
    _backBtnDispatcher?.removeCallback(_handleBackButton);
    if (_backBtnDispatcher is ChildBackButtonDispatcher) {
      final child = _backBtnDispatcher!;
      _parentBackBtnDispatcher?.forget(child);
    }
    _backBtnDispatcher = null;
    _parentBackBtnDispatcher = null;
  }

  bool get _onlyRoute => _route != null && _route!.isFirst && _route!.isCurrent;

  Future<bool> _handleBackButton() async {
    if (_onlyRoute) {
      widget.onPopInvokedWithResult?.call(widget.canPop, null);
      if (!widget.canPop) {
        return true;
      }
    }
    return false;
  }
}
