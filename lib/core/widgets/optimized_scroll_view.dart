import 'package:flutter/material.dart';

class OptimizedScrollView extends StatelessWidget {
  final Widget child;
  final bool hasScrollBody;
  final bool fillOverscroll;

  const OptimizedScrollView(
      {required this.child,
      this.hasScrollBody = false,
      this.fillOverscroll = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: hasScrollBody,
          child: child,
        )
      ],
    );
  }
}
