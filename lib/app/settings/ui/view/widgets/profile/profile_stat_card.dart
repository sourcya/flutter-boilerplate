part of '../../../imports/settings_imports.dart';

class ProfileStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final int delay;

  const ProfileStatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$label: $value',
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 16.r,
                  color: color,
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: CustomText(
                    label,
                    fontSize: 11.sp,
                    color: context.colors.onSurface.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            CustomText(
              value,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ],
        ),
      )
          .animate(delay: delay.ms)
          .fadeIn()
          .slideX(begin: -0.2, end: 0)
          .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),
    );
  }
}
