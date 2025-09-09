part of '../../../imports/settings_imports.dart';

class AnimatedProfileHeader extends GetView<SettingsController> {
  const AnimatedProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.currentUser.value.isLoading) {
        return _buildLoadingState(context);
      }

      final profile = controller.currentUser.value.data;
      if (profile == null) {
        return _buildErrorState(context);
        // return _buildEmptyState(context);
      }
      if (profile.id == null) {
        return _buildEmptyState(context);
      }

      return _buildProfileContent(context, profile);
    });
  }

  Widget _buildProfileContent(BuildContext context, UserProfile profile) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.colors.primary.withValues(alpha: 0.1),
            context.colors.secondary.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: context.colors.shadow.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Profile Image
              Hero(
                tag: 'profile_avatar',
                child: Container(
                  width: 80.r,
                  height: 80.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        context.colors.primary,
                        context.colors.secondary,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: context.colors.primary.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: profile.image?.url != null
                        ? ImageViewer.network(profile.image!.url!)
                        : Center(
                            child: CustomText(
                              profile.initials,
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                )
                    .animate()
                    .scale(
                      begin: const Offset(0.5, 0.5),
                      end: const Offset(1, 1),
                      duration: 600.ms,
                      curve: Curves.elasticOut,
                    )
                    .then()
                    .shimmer(
                      duration: 2000.ms,
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
              ),

              SizedBox(width: 20.w),

              // Profile Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Semantics(
                      label: 'User name: ${profile.displayName}',
                      child: CustomText(
                        profile.displayName,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      )
                          .animate()
                          .fadeIn(delay: 200.ms)
                          .slideX(begin: -0.2, end: 0),
                    ),
                    if (profile.email != null) ...[
                      SizedBox(height: 4.h),
                      Semantics(
                        label: 'Email: ${profile.email}',
                        child: CustomText(
                          profile.email!,
                          fontSize: 14.sp,
                          color:
                              context.colors.onSurface.withValues(alpha: 0.7),
                        )
                            .animate()
                            .fadeIn(delay: 300.ms)
                            .slideX(begin: -0.2, end: 0),
                      ),
                    ],
                    if (profile.phoneNumber != null) ...[
                      SizedBox(height: 4.h),
                      Semantics(
                        label: 'Phone: ${profile.phoneNumber}',
                        child: CustomText(
                          profile.phoneNumber!,
                          fontSize: 14.sp,
                          color:
                              context.colors.onSurface.withValues(alpha: 0.7),
                        )
                            .animate()
                            .fadeIn(delay: 400.ms)
                            .slideX(begin: -0.2, end: 0),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // Stats Row
          Row(
            children: [
              Expanded(
                child: ProfileStatCard(
                  label: 'Member Since',
                  value: profile.memberSince,
                  icon: Icons.calendar_today,
                  color: Colors.blue,
                  delay: 500,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ProfileStatCard(
                  label: 'Status',
                  value: profile.isVerified ? 'Verified' : 'Unverified',
                  icon: profile.isVerified ? Icons.verified : Icons.pending,
                  color: profile.isVerified ? Colors.green : Colors.orange,
                  delay: 600,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: Semantics(
                  button: true,
                  label: 'Edit Profile',
                  child: ElevatedButton.icon(
                    onPressed: controller.editProfile,
                    icon: const Icon(Icons.edit),
                    label: const CustomText('Edit Profile'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.2, end: 0),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Semantics(
                  button: true,
                  label: 'Share Profile',
                  child: OutlinedButton.icon(
                    onPressed: controller.shareProfile,
                    icon: const Icon(Icons.share),
                    label: const CustomText('Share'),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.2, end: 0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return Skeletonizer(
      child: Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: context.colors.surfaceContainer,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            Container(
              width: 80.r,
              height: 80.r,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20.h,
                    width: 150.w,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    height: 14.h,
                    width: 200.w,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40.r),
      child: Column(
        children: [
          Icon(
            Icons.account_circle,
            size: 80.r,
            color: context.colors.onSurface.withValues(alpha: 0.3),
          ),
          SizedBox(height: 16.h),
          CustomText(
            'No profile data',
            fontSize: 16.sp,
            color: context.colors.onSurface.withValues(alpha: 0.5),
          ),
        ],
      ),
    ).animate().fadeIn().scale(begin: const Offset(0.8, 0.8));
  }

  Widget _buildErrorState(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40.r),
      child: Column(
        children: [
          Icon(
            Icons.account_circle,
            size: 80.r,
            color: context.colors.onSurface.withValues(alpha: 0.3),
          ),
          SizedBox(height: 16.h),
          CustomText(
            'Failed to load profile data',
            fontSize: 16.sp,
            color: context.colors.onSurface.withValues(alpha: 0.5),
          ),
        ],
      ),
    ).animate().fadeIn().scale(begin: const Offset(0.8, 0.8));
  }
}
