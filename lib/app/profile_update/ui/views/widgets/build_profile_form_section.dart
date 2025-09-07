part of '../../imports/profile_imports.dart';

class BuildProfileFormSection extends GetView<EditProfileController> {
  const BuildProfileFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isCompact = screenWidth < 600;

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
          if (isCompact) ...[
            // Compact layout for mobile
            BuildProfileFieldWidget(
              fieldName: 'firstName',
              label: 'First Name',
              textController: controller.firstNameController,
              focus: controller.firstNameFocus,
              nextFocus: controller.lastNameFocus,
              icon: Icons.person_outline,
            ),
            SizedBox(height: 20.h),

            BuildProfileFieldWidget(
              fieldName: 'lastName',
              label: 'Last Name',
              textController: controller.lastNameController,
              focus: controller.lastNameFocus,
              nextFocus: controller.emailFocus,
              icon: Icons.person_outline,
            ),
          ] else ...[
            // Expanded layout for tablets/desktop
            Row(
              children: [
                Expanded(
                  child: BuildProfileFieldWidget(
                    fieldName: 'firstName',
                    label: 'First Name',
                    textController: controller.firstNameController,
                    focus: controller.firstNameFocus,
                    nextFocus: controller.lastNameFocus,
                    icon: Icons.person_outline,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: BuildProfileFieldWidget(
                    fieldName: 'lastName',
                    label: 'Last Name',
                    textController: controller.lastNameController,
                    focus: controller.lastNameFocus,
                    nextFocus: controller.emailFocus,
                    icon: Icons.person_outline,
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: 20.h),
          BuildProfileFieldWidget(
            fieldName: 'email',
            label: 'Email Address',
            textController: controller.emailController,
            focus: controller.emailFocus,
            nextFocus: controller.phoneFocus,
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 20.h),
          BuildProfileFieldWidget(
            fieldName: 'phone',
            label: 'Phone Number (Optional)',
            textController: controller.phoneController,
            focus: controller.phoneFocus,
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0);
  }
}
