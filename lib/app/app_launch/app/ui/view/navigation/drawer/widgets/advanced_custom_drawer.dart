part of '../../../../imports/app_imports.dart';

class AdvancedCustomDrawer extends StatefulWidget {
  const AdvancedCustomDrawer({
    super.key,
    required this.child,
    required this.drawer,
    this.controller,
    this.backdropColor,
    this.backdrop,
    this.openRatio = 0.75,
    this.openScale = 0.85,
    this.animationDuration = const Duration(milliseconds: 250),
    this.animationCurve,
    this.childDecoration,
    this.animateChildDecoration = true,
    this.rtlOpening = false,
    this.disabledGestures = false,
    this.animationController,
    this.breakpoint = 900.0,
    this.railMinWidth = 72.0,
    this.railMaxWidth = 250.0,
  });

  final Widget child;
  final Widget drawer;
  final AdvancedDrawerController? controller;
  final Color? backdropColor;
  final Widget? backdrop;
  final double openRatio;
  final double openScale;
  final Duration animationDuration;
  final Curve? animationCurve;
  final BoxDecoration? childDecoration;
  final bool animateChildDecoration;
  final bool rtlOpening;
  final bool disabledGestures;
  final AnimationController? animationController;
  final double breakpoint;
  final double railMinWidth;
  final double railMaxWidth;

  @override
  State<AdvancedCustomDrawer> createState() => _AdvancedDrawerState();
}

class _AdvancedDrawerState extends State<AdvancedCustomDrawer>
    with TickerProviderStateMixin {
  final _spareController = AdvancedDrawerController();
  late AnimationController _spareAnimationController;
  late AnimationController _animationController;
  late Animation<double> _drawerScaleAnimation;
  late Animation<Offset> _childSlideAnimation;
  late Animation<double> _childScaleAnimation;
  late Animation<Decoration> _childDecorationAnimation;
  late double _offsetValue;
  late Offset _freshPosition;
  bool _captured = false;
  Offset? _startPosition;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  @override
  void didUpdateWidget(covariant AdvancedCustomDrawer oldWidget) {
    _initControllers();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= widget.breakpoint;

    // --- DESKTOP / WEB (Rail Mode) ---
    if (isDesktop) {
      return Material(
        color: widget.backdropColor,
        child: Stack(
          children: [
            if (widget.backdrop != null) widget.backdrop!,
            Row(
              children: [
                ValueListenableBuilder<AdvancedDrawerValue>(
                  valueListenable: _controller,
                  builder: (_, value, __) {
                    // Calculate target width
                    final targetWidth = value.visible
                        ? widget.railMaxWidth
                        : widget.railMinWidth;

                    return AnimatedContainer(
                      duration: widget.animationDuration,
                      curve: widget.animationCurve ?? Curves.easeInOut,
                      width: targetWidth,
                      height: double.infinity,
                      child: widget.drawer,
                    );
                  },
                ),

                // if (!widget.rtlOpening)
                Expanded(
                  child: Container(
                    clipBehavior: widget.childDecoration != null
                        ? Clip.antiAlias
                        : Clip.none,
                    decoration: widget.childDecoration,
                    child: widget.child,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    // --- MOBILE (Original Drawer Mode) ---
    // (Keep this section exactly as it was)
    return Material(
      color: widget.backdropColor,
      child: GestureDetector(
        onHorizontalDragStart: widget.disabledGestures
            ? null
            : _handleDragStart,
        onHorizontalDragUpdate: widget.disabledGestures
            ? null
            : _handleDragUpdate,
        onHorizontalDragEnd: widget.disabledGestures ? null : _handleDragEnd,
        onHorizontalDragCancel: widget.disabledGestures
            ? null
            : _handleDragCancel,
        child: ColoredBox(
          color: Colors.transparent,
          child: Stack(
            children: [
              if (widget.backdrop != null) widget.backdrop!,
              Align(
                alignment: widget.rtlOpening
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: widget.openRatio,
                  child: ScaleTransition(
                    scale: _drawerScaleAnimation,
                    alignment: widget.rtlOpening
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: RepaintBoundary(child: widget.drawer),
                  ),
                ),
              ),
              SlideTransition(
                position: _childSlideAnimation,
                textDirection: widget.rtlOpening
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: ScaleTransition(
                  scale: _childScaleAnimation,
                  child: Builder(
                    builder: (_) {
                      final childStack = Stack(
                        children: [
                          RepaintBoundary(child: widget.child),
                          ValueListenableBuilder<AdvancedDrawerValue>(
                            valueListenable: _controller,
                            builder: (_, value, __) {
                              if (!value.visible) {
                                return const SizedBox();
                              }
                              return Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: _controller.hideDrawer,
                                  highlightColor: Colors.transparent,
                                  child: Container(),
                                ),
                              );
                            },
                          ),
                        ],
                      );

                      if (widget.animateChildDecoration &&
                          widget.childDecoration != null) {
                        return AnimatedBuilder(
                          animation: _childDecorationAnimation,
                          builder: (_, child) {
                            return Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: _childDecorationAnimation.value,
                              child: child,
                            );
                          },
                          child: childStack,
                        );
                      }

                      return Container(
                        clipBehavior: widget.childDecoration != null
                            ? Clip.antiAlias
                            : Clip.none,
                        decoration: widget.childDecoration,
                        child: childStack,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ... (Keep remainder of class: _controller, _initControllers, handlers, dispose)
  AdvancedDrawerController get _controller {
    return widget.controller ?? _spareController;
  }

  void _initControllers() {
    _controller
      ..removeListener(_handleControllerChanged)
      ..addListener(_handleControllerChanged);

    _spareAnimationController = AnimationController(
      vsync: this,
      value: _controller.value.visible ? 1 : 0,
    );

    _animationController =
        widget.animationController ?? _spareAnimationController;

    _animationController.reverseDuration = _animationController.duration =
        widget.animationDuration;

    final parentAnimation = widget.animationCurve == null
        ? _animationController
        : CurvedAnimation(
            curve: widget.animationCurve!,
            parent: _animationController,
          );

    _drawerScaleAnimation = Tween<double>(
      begin: 0.75,
      end: 1.0,
    ).animate(parentAnimation);

    _childSlideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(widget.openRatio, 0),
    ).animate(parentAnimation);

    _childScaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.openScale,
    ).animate(parentAnimation);

    _childDecorationAnimation = DecorationTween(
      begin: const BoxDecoration(),
      end: widget.childDecoration,
    ).animate(parentAnimation);
  }

  void _handleControllerChanged() {
    if (mounted && context.mounted) {
      _controller.value.visible
          ? _animationController.forward()
          : _animationController.reverse();
    }
  }

  void _handleDragStart(DragStartDetails details) {
    _captured = true;
    _startPosition = details.globalPosition;
    _offsetValue = _animationController.value;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!_captured) return;
    final screenSize = MediaQuery.of(context).size;
    _freshPosition = details.globalPosition;
    final diff = (_freshPosition - _startPosition!).dx;
    _animationController.value =
        _offsetValue +
        (diff / (screenSize.width * widget.openRatio)) *
            (widget.rtlOpening ? -1 : 1);
  }

  void _handleDragEnd(DragEndDetails details) {
    if (!_captured) return;
    _captured = false;
    if (_animationController.value >= 0.5) {
      if (_controller.value.visible) {
        _animationController.forward();
      } else {
        _controller.showDrawer();
      }
    } else {
      if (!_controller.value.visible) {
        _animationController.reverse();
      } else {
        _controller.hideDrawer();
      }
    }
  }

  void _handleDragCancel() {
    _captured = false;
  }

  @override
  void dispose() {
    _spareController
      ..removeListener(_handleControllerChanged)
      ..dispose();
    _spareAnimationController.dispose();
    super.dispose();
  }
}
