part of '../../imports/settings_imports.dart';

class BuildUserProfileHeader extends GetView<SettingsController> {
  const BuildUserProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final user = controller.currentUser.value;

      if (user == null) {
        return _buildLoadingState(context);
      }

      return LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 600;
          return _buildProfileCard(context, user, isCompact);
        },
      );
    });
  }
  

  Widget _buildProfileCard(
      BuildContext context, ApiUserInfo user, bool isCompact) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: context.colors.primary.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Stack(
          children: [
            // Animated Background
            _buildAnimatedBackground(context),

            // Content
            Padding(
              padding: EdgeInsets.all(24.r),
              child: isCompact
                  ? _buildCompactLayout(context, user)
                  : _buildExpandedLayout(context, user),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: -0.2, end: 0);
  }

  Widget _buildAnimatedBackground(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.colors.primary,
            context.colors.primary.withValues(alpha: 0.8),
            context.colors.secondary.withValues(alpha: 0.6),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Floating particles effect
          ...List.generate(
              5, (index) => _buildFloatingParticle(context, index)),

          // Mesh gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0.8, -0.5),
                radius: 1.5,
                colors: [
                  Colors.white.withValues(alpha: 0.1),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingParticle(BuildContext context, int index) {
    return Positioned(
      left: (index * 60.0 + 20).w,
      top: (index * 40.0 + 10).h,
      child: Container(
        width: (10 + index * 3.0).r,
        height: (10 + index * 3.0).r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.2),
        ),
      )
          .animate(onPlay: (controller) => controller.repeat())
          .moveY(
            begin: 0,
            end: -20,
            duration: (2000 + index * 500).ms,
            curve: Curves.easeInOut,
          )
          .then()
          .moveY(
            begin: -20,
            end: 0,
            duration: (2000 + index * 500).ms,
            curve: Curves.easeInOut,
          ),
    );
  }

  Widget _buildCompactLayout(BuildContext context, ApiUserInfo user) {
    return Column(
      children: [
        _buildProfileImage(context, user),
        SizedBox(height: 16.h),
        _buildUserInfo(context, user),
        SizedBox(height: 20.h),
        _buildStatsRow(context, user),
        SizedBox(height: 16.h),
        _buildActionButtons(context),
      ],
    );
  }

  Widget _buildExpandedLayout(BuildContext context, ApiUserInfo user) {
    return Row(
      children: [
        _buildProfileImage(context, user),
        SizedBox(width: 24.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserInfo(context, user),
              SizedBox(height: 16.h),
              _buildStatsRow(context, user),
              SizedBox(height: 16.h),
              _buildActionButtons(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage(BuildContext context, ApiUserInfo user) {
    return Hero(
      tag: 'profile_image',
      child: Stack(
        children: [
          Container(
            width: 100.r,
            height: 100.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 4,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipOval(
              child: user.image?.url != null
                  ? ImageViewer.network(user.image!.url!)
                  : Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.3),
                            Colors.white.withValues(alpha: 0.1),
                          ],
                        ),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 45.r,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
          // Online status indicator
          Positioned(
            bottom: 8.h,
            right: 8.w,
            child: Container(
              width: 20.r,
              height: 20.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
                border: Border.all(color: Colors.white, width: 3),
              ),
            )
                .animate(onPlay: (controller) => controller.repeat())
                .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.2, 1.2),
                  duration: 1500.ms,
                  curve: Curves.easeInOut,
                )
                .then()
                .scale(
                  begin: const Offset(1.2, 1.2),
                  end: const Offset(1, 1),
                  duration: 1500.ms,
                  curve: Curves.easeInOut,
                ),
          ),
        ],
      )
          .animate()
          .scale(
            begin: const Offset(0.5, 0.5),
            end: const Offset(1, 1),
            duration: 600.ms,
            curve: Curves.elasticOut,
          )
          .then(delay: 200.ms)
          .shimmer(
            duration: 2000.ms,
            color: Colors.white.withValues(alpha: 0.3),
          ),
    );
  }

  Widget _buildUserInfo(BuildContext context, ApiUserInfo user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          '${user.firstName} ${user.lastName}',
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          shadows: [
            Shadow(
              color: Colors.black.withValues(alpha: 0.3),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.3, end: 0),
        SizedBox(height: 4.h),
        CustomText(
          user.email ?? "",
          fontSize: 15.sp,
          color: Colors.white.withValues(alpha: 0.9),
          fontWeight: FontWeight.w500,
        ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.3, end: 0),
        if (user.username != null && user.username!.isNotEmpty) ...[
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: CustomText(
              user.username ?? "",
              fontSize: 13.sp,
              color: Colors.white.withValues(alpha: 0.9),
              fontStyle: FontStyle.italic,
              maxLines: 2,
              textOverflow: TextOverflow.ellipsis,
            ),
          ).animate().fadeIn(delay: 500.ms).slideX(begin: -0.3, end: 0),
        ],
      ],
    );
  }

  Widget _buildStatsRow(BuildContext context, ApiUserInfo user) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context: context,
            label: 'Member Since',
            value: _formatDate(
                DateTime.parse(user.createdAt ?? DateTime.now().toString())),
            icon: Icons.calendar_today_outlined,
            delay: 600,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildStatCard(
            context: context,
            label: 'Status',
            value: 'Active',
            icon: Icons.verified_user_outlined,
            delay: 700,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required String label,
    required String value,
    required IconData icon,
    required int delay,
  }) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
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
                color: Colors.white.withValues(alpha: 0.9),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: CustomText(
                  label,
                  fontSize: 11.sp,
                  color: Colors.white.withValues(alpha: 0.8),
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
            color: Colors.white,
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: delay.ms)
        .slideX(begin: -0.2, end: 0)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1));
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            context: context,
            icon: Icons.edit_outlined,
            label: 'Edit Profile',
            onTap: () {
              HapticFeedback.lightImpact();
              PlayxNavigation.toNamed(Routes.updateprofile);
            },
            delay: 800,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildActionButton(
            context: context,
            icon: Icons.share_outlined,
            label: 'Share',
            onTap: () => controller.shareProfile(),
            delay: 900,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required int delay,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 18.r,
                  color: Colors.white,
                ),
                SizedBox(width: 8.w),
                CustomText(
                  label,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(delay: delay.ms)
        .slideY(begin: 0.3, end: 0)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1));
  }

  Widget _buildLoadingState(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        children: [
          // Avatar skeleton
          Container(
            width: 100.r,
            height: 100.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colors.onSurface.withValues(alpha: 0.1),
            ),
          ),
          SizedBox(width: 24.w),

          // Content skeleton
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name skeleton
                Container(
                  height: 24.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                    color: context.colors.onSurface.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                SizedBox(height: 8.h),

                // Email skeleton
                Container(
                  height: 16.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                    color: context.colors.onSurface.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                SizedBox(height: 16.h),

                // Stats skeleton
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 60.h,
                        decoration: BoxDecoration(
                          color:
                              context.colors.onSurface.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Container(
                        height: 60.h,
                        decoration: BoxDecoration(
                          color:
                              context.colors.onSurface.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate(onPlay: (controller) => controller.repeat()).shimmer(
          duration: 2000.ms,
          color: context.colors.primary.withValues(alpha: 0.1),
        );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '${years}y ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '${months}m ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
