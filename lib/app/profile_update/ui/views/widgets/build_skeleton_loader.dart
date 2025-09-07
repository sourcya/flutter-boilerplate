part of '../../imports/profile_imports.dart';

class BuildSkeletonLoader extends StatelessWidget {
  const BuildSkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return OptimizedScrollView(
      child: Column(
        children: [
          // Header Skeleton
          _buildHeaderSkeleton(context),

          // Profile Image Skeleton
          _buildProfileImageSkeleton(context),
          SizedBox(height: 24.h),

          // Form Section Skeleton
          _buildFormSectionSkeleton(context),
          SizedBox(height: 32.h),

          // Save Button Skeleton
          _buildSaveButtonSkeleton(context),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  Widget _buildHeaderSkeleton(BuildContext context) {
    return Container(
      height: 60.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: SkeletonAnimation(
        shimmerColor: context.colors.onSurface.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          decoration: BoxDecoration(
            color: context.colors.surfaceContainer,
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImageSkeleton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        children: [
          // Title Skeleton
          SkeletonAnimation(
            shimmerColor: context.colors.onSurface.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              height: 20.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: context.colors.surfaceContainer,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Profile Image Circle Skeleton
          SkeletonAnimation(
            shimmerColor: context.colors.onSurface.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(60.r),
            child: Container(
              width: 120.r,
              height: 120.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.surfaceContainer,
                border: Border.all(
                  color: context.colors.outline.withValues(alpha: 0.2),
                  width: 3,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Change Photo Button Skeleton
          SkeletonAnimation(
            shimmerColor: context.colors.onSurface.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              height: 40.h,
              width: 140.w,
              decoration: BoxDecoration(
                color: context.colors.surfaceContainer,
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSectionSkeleton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: context.colors.shadow.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // First Name Field
          _buildFieldSkeleton(context),
          SizedBox(height: 20.h),

          // Last Name Field
          _buildFieldSkeleton(context),
          SizedBox(height: 20.h),

          // Email Field
          _buildFieldSkeleton(context),
          SizedBox(height: 20.h),

          // Phone Field
          _buildFieldSkeleton(context),
        ],
      ),
    );
  }

  Widget _buildFieldSkeleton(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Field Label
        SkeletonAnimation(
          shimmerColor: context.colors.onSurface.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(6.r),
          child: Container(
            height: 16.h,
            width: 80.w,
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
        ),
        SizedBox(height: 8.h),

        // Field Input
        SkeletonAnimation(
          shimmerColor: context.colors.onSurface.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            height: 52.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: context.colors.outline.withValues(alpha: 0.2),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButtonSkeleton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: SkeletonAnimation(
        shimmerColor: context.colors.onSurface.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          height: 56.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.colors.surfaceContainer,
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
      ),
    );
  }
}

// Custom Skeleton Animation Widget
class SkeletonAnimation extends StatefulWidget {
  final Widget child;
  final Color? shimmerColor;
  final BorderRadius? borderRadius;
  final Duration duration;

  const SkeletonAnimation({
    super.key,
    required this.child,
    this.shimmerColor,
    this.borderRadius,
    this.duration = const Duration(milliseconds: 1200),
  });

  @override
  State<SkeletonAnimation> createState() => _SkeletonAnimationState();
}

class _SkeletonAnimationState extends State<SkeletonAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shimmerColor =
        widget.shimmerColor ?? context.colors.onSurface.withValues(alpha: 0.1);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            gradient: LinearGradient(
              begin: Alignment(_animation.value, 0),
              end: Alignment(_animation.value + 1, 0),
              colors: [
                shimmerColor.withValues(alpha: 0.1),
                shimmerColor.withValues(alpha: 0.3),
                shimmerColor.withValues(alpha: 0.1),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}
