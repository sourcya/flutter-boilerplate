part of '../../ui.dart';

/// Circular WhatsApp-style support control used in the app bar and drawer.
class SupportButton extends StatelessWidget {
  final double size;
  final bool isShowLabel;
  final bool isExpanded;

  const SupportButton({
    super.key,
    this.size = 44,
    this.isShowLabel = false,
    this.isExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!isShowLabel) {
      return const _CircularSupportButton();
    }
    if (!isExpanded) {
      return Padding(
        padding: context.paddingSymmetric(vertical: 8),
        child: const Center(child: _CircularSupportButton()),
      );
    }
    return const _ExpandedSupportButton();
  }
}

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
      decoration: const ShapeDecoration(
        color: AppColors.basewhite,
        shape: CircleBorder(),
      ),
      child: Center(
        child: Lottie.asset(
          Assets.animations.support,
          width: iconSize,
          height: iconSize,
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.support_agent,
            size: iconSize * 0.7,
            color: context.colors.primary,
          ),
        ),
      ),
    );
  }
}

class _CircularSupportButton extends StatelessWidget {
  const _CircularSupportButton();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      hitTestBehavior: HitTestBehavior.opaque,
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => contactSupportViaWhatsapp(context: context),
        child: Container(
          width: 32.0.r,
          height: 32.0.r,
          decoration: ShapeDecoration(
            color: AppColors.brandPrimary,
            shape: const CircleBorder(),
            shadows: AppShadows.supportButton(context),
          ),
          child: Center(
            child: _SupportIconCircle(circleSize: 24.0.r, iconSize: 24.0.r),
          ),
        ),
      ),
    );
  }
}

class _ExpandedSupportButton extends StatelessWidget {
  const _ExpandedSupportButton();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      hitTestBehavior: HitTestBehavior.opaque,
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => contactSupportViaWhatsapp(context: context),
        child: Container(
          width: context.width,
          height: 48.r,
          margin: context.paddingSymmetric(horizontal: 8, vertical: 8),
          padding: context.paddingOnly(start: 6, end: 12),
          decoration: ShapeDecoration(
            color: context.colors.primary,
            shape: const StadiumBorder(),
            shadows: AppShadows.supportButton(context),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _SupportIconCircle(circleSize: 36.r, iconSize: 36.r),
              6.wBox,
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
      ),
    );
  }
}
