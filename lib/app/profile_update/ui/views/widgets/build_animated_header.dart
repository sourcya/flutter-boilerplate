part of '../../imports/profile_imports.dart';

class BuildAnimatedHeader extends GetView<EditProfileController> {
  const BuildAnimatedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  context.colors.primary.withValues(alpha: 0.1),
                  context.colors.secondary.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),

          // Content
          Center(
            child: CustomText(
              'Update your profile information',
              fontSize: 14.sp,
              color: context.colors.onSurface.withValues(alpha: 0.7),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3, end: 0);
  }
}
