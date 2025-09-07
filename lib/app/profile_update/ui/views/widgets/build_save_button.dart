part of '../../imports/profile_imports.dart';

class BuildSaveButton extends GetView<EditProfileController> {
  const BuildSaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Obx(() {
        final isFormValid = controller.isFormValid.value;
        final isSaving = controller.isSaving.value;
        final hasChanges = controller.hasChanges.value;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: CustomElevatedButton(
            onPressed: isFormValid && !isSaving && hasChanges
                ? () => _handleSaveProfile(context)
                : null,
            color: isFormValid && hasChanges
                ? context.colors.primary
                : context.colors.onSurface.withValues(alpha: 0.3),
            padding: EdgeInsets.symmetric(vertical: 16.h),
            borderRadius: BorderRadius.circular(16.r),
            child: SizedBox(
              height: 24.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Save Content
                  AnimatedOpacity(
                    opacity: isSaving ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          hasChanges
                              ? Icons.save_outlined
                              : Icons.check_circle_outline,
                          size: 20.r,
                          color: isFormValid && hasChanges
                              ? Colors.white
                              : Colors.grey.withValues(alpha: 0.7),
                        ),
                        SizedBox(width: 8.w),
                        CustomText(
                          hasChanges ? 'Save Profile' : 'No Changes',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: isFormValid && hasChanges
                              ? Colors.white
                              : Colors.grey.withValues(alpha: 0.7),
                        ),
                      ],
                    ),
                  ),

                  // Loading Indicator
                  AnimatedOpacity(
                    opacity: isSaving ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20.r,
                          height: 20.r,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        CustomText(
                          'Saving...',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0);
  }

  Future<void> _handleSaveProfile(BuildContext context) async {
    try {
      // Unfocus all text fields
      FocusScope.of(context).unfocus();

      // Add haptic feedback
      HapticFeedback.mediumImpact();

      // Save profile
      final success = await controller.saveProfile();

      if (success) {
        // Success feedback
        // HapticFeedback.notificationImpact(NotificationFeedbackType.success);

        // Show success message
        Alert.success(
          message: 'Profile updated successfully!',
          duration: const Duration(seconds: 2),
        );

        // Optional: Navigate back or perform other actions
        // PlayxNavigation.pop();
      } else {
        // Error feedback
        // HapticFeedback.notificationImpact(NotificationFeedbackType.error);

        // Show error message
        Alert.error(
          message: 'Failed to update profile. Please try again.',
        );
      }
    } catch (e) {
      // Handle unexpected errors
      // HapticFeedback.notificationImpact(NotificationFeedbackType.error);
      Alert.error(message: 'An unexpected error occurred.');
      Sentry.captureException(e);
    }
  }
}
