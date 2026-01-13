import 'package:flutter/material.dart';

class AnimatedWidgetWrapper extends StatefulWidget {
  final Widget child;
  final bool enableAnimation;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final Offset slideOffset;
  final bool fadeIn;
  final bool slideIn;
  final bool scaleIn;

  const AnimatedWidgetWrapper({
    super.key,
    required this.child,
    this.enableAnimation = true,
    this.duration = const Duration(milliseconds: 400),
    this.delay = Duration.zero,
    this.curve = Curves.easeOutCubic,
    this.slideOffset = const Offset(0, 0.02),
    this.fadeIn = true,
    this.slideIn = true,
    this.scaleIn = false,
  });

  @override
  State<AnimatedWidgetWrapper> createState() => _AnimatedWidgetWrapperState();
}

class _AnimatedWidgetWrapperState extends State<AnimatedWidgetWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _fadeAnimation =
        Tween<double>(
          begin: widget.fadeIn ? 0.0 : 1.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: widget.curve,
          ),
        );

    _slideAnimation =
        Tween<Offset>(
          begin: widget.slideIn ? widget.slideOffset : Offset.zero,
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: widget.curve,
          ),
        );

    _scaleAnimation =
        Tween<double>(
          begin: widget.scaleIn ? 0.95 : 1.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: widget.curve,
          ),
        );

    if (widget.enableAnimation) {
      Future.delayed(widget.delay, () {
        if (mounted) {
          _controller.forward();
        }
      });
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enableAnimation) {
      return widget.child;
    }

    Widget result = widget.child;

    if (widget.scaleIn) {
      result = ScaleTransition(scale: _scaleAnimation, child: result);
    }

    if (widget.slideIn) {
      result = SlideTransition(position: _slideAnimation, child: result);
    }

    if (widget.fadeIn) {
      result = FadeTransition(opacity: _fadeAnimation, child: result);
    }

    return result;
  }
}

/// Staggered animation wrapper for lists
class StaggeredAnimationWrapper extends StatelessWidget {
  final Widget child;
  final int index;
  final bool enableAnimation;
  final Duration baseDelay;
  final Duration staggerDelay;

  const StaggeredAnimationWrapper({
    super.key,
    required this.child,
    required this.index,
    this.enableAnimation = true,
    this.baseDelay = const Duration(milliseconds: 100),
    this.staggerDelay = const Duration(milliseconds: 50),
  });

  @override
  Widget build(BuildContext context) {
    return switch (enableAnimation) {
      true => AnimatedWidgetWrapper(
        enableAnimation: enableAnimation,
        delay: baseDelay + (staggerDelay * index),
        child: child,
      ),
      _ => child,
    };
  }
}
