part of '../../imports/profile_imports.dart';

class BuildProfileImageSection extends GetView<EditProfileController> {
  const BuildProfileImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        children: [
          CustomText(
            'Profile Photo',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: context.colors.onSurface,
          ),
          SizedBox(height: 16.h),
          _buildImageContainer(context),
          SizedBox(height: 16.h),
          _buildImageActionButton(context),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildImageContainer(BuildContext context) {
    return Hero(
      tag: 'edit_profile_image',
      child: Container(
        width: 120.r,
        height: 120.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: context.colors.primary.withValues(alpha: 0.3),
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: context.colors.primary.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipOval(
          child: _buildImageContent(context),
        ),
      ),
    );
  }

  Widget _buildImageContent(BuildContext context) {
    return Obx(() {
      if (controller.selectedImage.value != null) {
        return Image.file(
          controller.selectedImage.value!,
          fit: BoxFit.cover,
          width: 120.r,
          height: 120.r,
        );
      }

      if (controller.currentImageUrl.value.isNotEmpty) {
        return ImageViewer.network(
          controller.currentImageUrl.value,
          width: 120.r,
          height: 120.r,
        );
      }

      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              context.colors.primary.withValues(alpha: 0.3),
              context.colors.secondary.withValues(alpha: 0.2),
            ],
          ),
        ),
        child: Icon(
          Icons.person,
          size: 50.r,
          color: context.colors.onSurface.withValues(alpha: 0.6),
        ),
      );
    });
  }

  Widget _buildImageActionButton(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () => controller.showImagePicker(context),
      color: context.colors.primary.withValues(alpha: 0.1),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      borderRadius: BorderRadius.circular(20.r),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.camera_alt_outlined,
            size: 18.r,
            color: context.colors.primary,
          ),
          SizedBox(width: 8.w),
          CustomText(
            'Change Photo',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: context.colors.primary,
          ),
        ],
      ),
    );
  }
}
