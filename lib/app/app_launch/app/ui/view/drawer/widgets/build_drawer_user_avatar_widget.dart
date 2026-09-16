part of '../../../imports/app_imports.dart';

class BuildDrawerUserAvatarWidget extends StatelessWidget {
  final String? initials;
  final bool showUserImg;
  final String? imageUrl;
  final bool isExpanded;
  final bool isPortraitDrawer;
  const BuildDrawerUserAvatarWidget({
    super.key,
    this.initials,
    this.showUserImg = false,
    this.imageUrl,
    this.isExpanded = false,
    this.isPortraitDrawer = false,
  });

  @override
  Widget build(BuildContext context) {
    if (showUserImg && !isExpanded) {
      return Container(
        decoration: ShapeDecoration(
          color: context.colors.mutedForeground.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: ImageViewer.cachedNetwork(imageUrl ?? '', width: 32.r, height: 32.r),
      );
    }

    return Container(
      width: 32.r,
      height: 32.r,
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: context.colors.primaryFixedDim,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: CustomText(
        initials?.isNotEmpty == true ? initials! : 'K',
        color: context.colors.onPrimaryFixed,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        height: 1,
        maxLines: 1,
        textAlign: TextAlign.center,
        isTranslatable: false,
      ),
    );
  }
}
