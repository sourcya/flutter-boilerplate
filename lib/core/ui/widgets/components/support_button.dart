part of '../../ui.dart';

/// A reusable support button widget that opens WhatsApp support when tapped.
/// The button has a circular blue design with a WhatsApp icon.
class SupportButton extends StatelessWidget {
  /// The size of the button. Defaults to 44.
  final double size;

  /// Whether to show the label text (for drawer/sidebar).
  final bool isShowLabel;

  /// Whether the button is expanded (for drawer).
  final bool isExpanded;

  const SupportButton({
    super.key,
    this.size = 44,
    this.isShowLabel = false,
    this.isExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    // Non-drawer state - circular button only (for app bar)
    if (!isShowLabel) {
      return const _CircularSupportButton();
    }

    // Drawer collapsed state - circular button centered
    if (!isExpanded) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.r),
        child: const Center(child: _CircularSupportButton()),
      );
    }

    // Expanded state - full button with text inside the blue card (drawer design)
    return const _ExpandedSupportButton();
  }
}

/// Circular icon container with surface background
class _SupportIconCircle extends StatelessWidget {
  final double circleSize;
  final double iconSize;

  const _SupportIconCircle({
    required this.circleSize,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleSize,
      height: circleSize,
      decoration: ShapeDecoration(
        color: context.colors.surface,
        shape: const CircleBorder(),
      ),
      child: Center(
        child: Lottie.asset(
          Assets.animations.support,
          width: iconSize,
          height: iconSize,
        ),
      ),
    );
  }
}

/// Circular button used in non-expanded states (app bar & collapsed drawer)
class _CircularSupportButton extends StatelessWidget {
  const _CircularSupportButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => contactSupportViaWhatsapp(context: context),
      child: Container(
        width: 32.0.r,
        height: 32.0.r,
        decoration: ShapeDecoration(
          color: context.colors.primary,
          shape: const CircleBorder(),
          shadows: Style.supportButtonStyle(context),
        ),
        child: Center(
          child: _SupportIconCircle(circleSize: 24.0.r, iconSize: 24.0.r),
        ),
      ),
    );
  }
}

/// Expanded button with text (drawer design)
class _ExpandedSupportButton extends StatelessWidget {
  const _ExpandedSupportButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => contactSupportViaWhatsapp(context: context),
      child: Container(
        width: context.width,
        height: 48.r,
        margin: EdgeInsets.symmetric(horizontal: 8.r, vertical: 8.r),
        padding: EdgeInsets.only(left: 6.r, right: 12.r),
        decoration: ShapeDecoration(
          color: context.colors.primary,
          shape: const StadiumBorder(),
          shadows: Style.supportButtonStyle(context),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SupportIconCircle(circleSize: 36.r, iconSize: 36.r),
            SizedBox(width: 6.r),
            CustomText(
              AppTrans.support.tr(),
              color: context.colors.onPrimary,
              fontSize: 15.43.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.39,
            ),
          ],
        ),
      ),
    );
  }
}
