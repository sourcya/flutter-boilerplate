part of '../../imports/onboarding_imports.dart';

class OnboardingSegmentProgressWidget extends StatelessWidget {
  final int activeIndex;
  final int segmentCount;
  final Color? color;
  final double barHeight;

  const OnboardingSegmentProgressWidget({
    super.key,
    required this.activeIndex,
    required this.segmentCount,
    this.color,
    this.barHeight = 6,
  });

  @override
  Widget build(BuildContext context) {
    final barColor = color ?? context.colors.secondary;
    final segments = <Widget>[];
    for (var i = 0; i < segmentCount; i++) {
      if (i > 0) segments.add(8.wBox);
      final isActive = i == activeIndex;
      final bar = AnimatedContainer(
        duration: ResponsiveConfig.animationDuration,
        decoration: ShapeDecoration(
          color: barColor,
          shape: RoundedRectangleBorder(borderRadius: 2.radius),
        ),
        child: barHeight.hBox,
      );
      segments.add(
        Expanded(
          child: isActive
              ? bar
              : AnimatedOpacity(
                  opacity: 0.5,
                  duration: ResponsiveConfig.animationDuration,
                  child: bar,
                ),
        ),
      );
    }

    return Row(children: segments);
  }
}
