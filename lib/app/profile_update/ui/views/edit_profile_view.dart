part of '../imports/profile_imports.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Edit Profile',
      color: context.colors.primary,
      child: CustomScaffold(
        backgroundColor: context.colors.surface,
        appBar: PlatformAppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: context.colors.onSurface,
            ),
            onPressed: () => Get.back(),
          ),
          title: CustomText(
            'Edit Profile',
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: context.colors.onSurface,
          ),
        ),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const BuildSkeletonLoader();
          }

          return OptimizedScrollView(
            child: Column(
              children: [
                const BuildAnimatedHeader(),
                const BuildProfileImageSection(),
                SizedBox(height: 24.h),
                const BuildProfileFormSection(),
                SizedBox(height: 32.h),
                const BuildSaveButton(),
                SizedBox(height: 32.h),
              ],
            ),
          );
        }),
      ),
    );
  }
}
