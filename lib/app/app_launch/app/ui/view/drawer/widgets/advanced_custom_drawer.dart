part of '../../../imports/app_imports.dart';

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
    this.railMinWidth = ResponsiveConfig.railWidth,
    this.railMaxWidth = ResponsiveConfig.drawerExpandedRailWidth,
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

class _AdvancedDrawerState extends State<AdvancedCustomDrawer> with TickerProviderStateMixin {
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
    _setupControllers();
  }

  @override
  void didUpdateWidget(covariant AdvancedCustomDrawer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.animationDuration != widget.animationDuration ||
        oldWidget.animationCurve != widget.animationCurve ||
        oldWidget.openRatio != widget.openRatio ||
        oldWidget.openScale != widget.openScale ||
        oldWidget.childDecoration != widget.childDecoration) {
      _setupControllers();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= widget.breakpoint && context.isAppLandscape;

    // --- DESKTOP / WEB (Rail Mode) ---
    if (isDesktop) {
      return Material(
        color: widget.backdropColor,
        child: Stack(
          children: [
            if (widget.backdrop != null) widget.backdrop!,
            LayoutBuilder(
              builder: (context, constraints) {
                return ValueListenableBuilder<AdvancedDrawerValue>(
                  valueListenable: _controller,
                  builder: (context, value, child) {
                    final targetWidth = value.visible ? widget.railMaxWidth : widget.railMinWidth;
                    final borderRadius = context.isCurrentLocaleArabic
                        ? BorderRadius.only(
                            topLeft: Radius.circular(16.r),
                            bottomLeft: Radius.circular(16.r),
                          )
                        : BorderRadius.only(
                            topRight: Radius.circular(16.r),
                            bottomRight: Radius.circular(16.r),
                          );
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Row(
                          children: [
                            AnimatedContainer(
                              duration: widget.animationDuration,
                              curve: widget.animationCurve ?? Curves.easeInOut,
                              width: targetWidth,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: context.colors.background,
                                borderRadius: borderRadius,
                                border: BorderDirectional(
                                  end: BorderSide(
                                    color: context.colors.border,
                                    width: 1.r,
                                  ),
                                ),
                              ),
                              child: SafeArea(
                                left: false,
                                right: false,
                                bottom: false,
                                child: widget.drawer,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                clipBehavior: widget.childDecoration != null
                                    ? Clip.antiAlias
                                    : Clip.none,
                                decoration: widget.childDecoration,
                                child: SafeArea(
                                  left: false,
                                  right: false,
                                  bottom: false,
                                  child: widget.child,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Button positioned so it straddles the drawer/content border:
                        // its center aligns with targetWidth, so 10.r on drawer side, 10.r on content side
                        AnimatedPositionedDirectional(
                          duration: widget.animationDuration,
                          curve: widget.animationCurve ?? Curves.easeInOut,
                          top: 14.r,
                          start: targetWidth - (20.r / 2),
                          child: SafeArea(
                            left: false,
                            right: false,
                            bottom: false,
                            child: WebSelectionDisabledGestureDetector(
                              onTap: value.visible
                                  ? _controller.hideDrawer
                                  : _controller.showDrawer,
                              child: Builder(
                                builder: (context) {
                                  final rtl = context.isCurrentLocaleArabic;
                                  final iconPath = rtl
                                      ? (value.visible
                                            ? Assets.icons.icDoubleArrowRight
                                            : Assets.icons.icDoubleArrowLeft)
                                      : (value.visible
                                            ? Assets.icons.icDoubleArrowLeft
                                            : Assets.icons.icDoubleArrowRight);
                                  return Container(
                                    padding: context.paddingAll(2.0),
                                    constraints: BoxConstraints(minWidth: 20.r, minHeight: 20.r),
                                    decoration: BoxDecoration(
                                      color: context.colors.primaryFixedDim,
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                    child: IconInfo.svg(
                                      iconPath,
                                      size: 16.r,
                                      color: context.colors.onPrimaryFixed,
                                    ).buildIconWidget(),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      );
    }
    // --- MOBILE (Standard Width Like Flutter Drawer) ---
    final drawerSlideAnimation = widget.animationCurve == null
        ? _animationController
        : CurvedAnimation(
            parent: _animationController,
            curve: widget.animationCurve!,
            reverseCurve: widget.animationCurve,
          );

    return Material(
      color: widget.backdropColor,
      child: WebSelectionDisabledGestureDetector(
        onHorizontalDragStart: widget.disabledGestures ? null : _handleDragStart,
        onHorizontalDragUpdate: widget.disabledGestures ? null : _handleDragUpdate,
        onHorizontalDragEnd: widget.disabledGestures ? null : _handleDragEnd,
        onHorizontalDragCancel: widget.disabledGestures ? null : _handleDragCancel,
        child: Stack(
          children: [
            if (widget.backdrop != null) widget.backdrop!,
            widget.child,
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                if (_animationController.value == 0) {
                  return const SizedBox();
                }

                return Opacity(
                  opacity: _animationController.value * 0.4,
                  child: WebSelectionDisabledGestureDetector(
                    onTap: _controller.hideDrawer,
                    child: Container(
                      width: context.width,
                      height: context.height,
                      color: widget.backdropColor ?? context.colors.shadow,
                    ),
                  ),
                );
              },
            ),
            SlideTransition(
              position: Tween<Offset>(
                begin: widget.rtlOpening ? const Offset(1, 0) : const Offset(-1, 0),
                end: Offset.zero,
              ).animate(drawerSlideAnimation),
              child: Align(
                alignment: widget.rtlOpening ? Alignment.centerRight : Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: widget.openRatio,
                  child: widget.drawer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ... (Keep remainder of class: _controller, _initControllers, handlers, dispose)
  AdvancedDrawerController get _controller {
    return widget.controller ?? _spareController;
  }

  void _setupControllers() {
    _controller
      ..removeListener(_handleControllerChanged)
      ..addListener(_handleControllerChanged);

    _spareAnimationController = AnimationController(
      vsync: this,
      value: _controller.value.visible ? 1 : 0,
    );

    _animationController = widget.animationController ?? _spareAnimationController;

    _animationController.reverseDuration = _animationController.duration = widget.animationDuration;

    final parentAnimation = widget.animationCurve == null
        ? _animationController
        : CurvedAnimation(
            curve: widget.animationCurve!,
            reverseCurve: widget.animationCurve,
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
      _controller.value.visible ? _animationController.forward() : _animationController.reverse();
    }
  }

  void _handleDragStart(DragStartDetails details) {
    _captured = true;
    _startPosition = details.globalPosition;
    _offsetValue = _animationController.value;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!_captured) return;
    final screenSize = MediaQuery.sizeOf(context);
    _freshPosition = details.globalPosition;
    final diff = (_freshPosition - _startPosition!).dx;
    _animationController.value =
        _offsetValue +
        (diff / (screenSize.width * widget.openRatio)) * (widget.rtlOpening ? -1 : 1);
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
