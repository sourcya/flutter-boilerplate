import 'package:flutter/material.dart';

/// This is an optimized scroll view widget that make it's child scrollable.
/// It will automatically size itself to fill the space
/// between the bottom of the last widget and the bottom of the viewport.
class OptimizedScrollView extends StatelessWidget {
  final Widget child;
  final bool hasScrollBody;
  final bool fillOverscroll;

  const OptimizedScrollView({
    required this.child,
    this.hasScrollBody = false,
    this.fillOverscroll = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: hasScrollBody,
          fillOverscroll: fillOverscroll,
          child: child,
        )
      ],
    );
  }
}
