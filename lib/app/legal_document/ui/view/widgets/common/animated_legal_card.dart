part of '../../../imports/legal_imports.dart';

class AnimatedLegalCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final int index;
  final bool isExpanded;

  const AnimatedLegalCard({
    super.key,
    required this.child,
    this.onTap,
    this.index = 0,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: isExpanded
            ? BorderSide(color: context.colors.primary, width: 2)
            : BorderSide.none,
      ),
      elevation: AppUtils.isDarkMode() ? 8 : 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
          padding: EdgeInsets.all(isExpanded ? 20.r : 16.r),
          child: child,
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: 100 * index))
        .fadeIn(duration: 600.ms, curve: Curves.easeOutQuad)
        .slideY(begin: 0.2, end: 0, duration: 600.ms, curve: Curves.easeOutQuad)
        .scale(
            begin: const Offset(0.95, 0.95),
            end: const Offset(1, 1),
            duration: 400.ms);
  }
}
