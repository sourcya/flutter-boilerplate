part of '../../../imports/settings_imports.dart';

class SettingsSectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? color;

  const SettingsSectionHeader({
    super.key,
    required this.title,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = color ?? context.colors.primary;

    return Semantics(
      header: true,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                icon,
                size: 20.r,
                color: primaryColor,
              ),
            ),
            SizedBox(width: 12.w),
            CustomText(
              title,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: context.colors.onSurface,
            ),
          ],
        ),
      ).animate().fadeIn().slideX(begin: -0.1, end: 0),
    );
  }
}
