part of '../../imports/login_imports.dart';

class LoginPanelSegmentIndicatorsWidget extends StatelessWidget {
  final LoginOnboardingController controller;

  const LoginPanelSegmentIndicatorsWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final slideCount = loginOnboardingSlides.length;
        final activeIndex = controller.currentPage.value;
        final bars = <Widget>[];
        for (var i = 0; i < slideCount; i++) {
          if (i > 0) {
            bars.add(4.wBox);
          }
          bars.add(
            Expanded(
              child: AnimatedContainer(
                duration: ResponsiveConfig.animationDuration,
                curve: ResponsiveConfig.animationCurve,
                height: 4.0.r,
                decoration: BoxDecoration(
                  color: context.colors.primary.withValues(
                    alpha: i == activeIndex ? 1 : 0.5,
                  ),
                  borderRadius: 2.radius,
                ),
              ),
            ),
          );
        }
        return SizedBox(
          width: 200.r,
          child: Row(
            children: bars,
          ),
        );
      },
    );
  }
}
