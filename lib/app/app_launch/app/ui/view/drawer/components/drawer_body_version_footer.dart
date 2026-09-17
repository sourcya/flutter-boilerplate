part of '../../../imports/app_imports.dart';

/// Bottom strip showing the app version in the expanded sidebar footer.
class _DrawerBodyVersionFooter extends StatelessWidget {
  final bool isExpanded;

  const _DrawerBodyVersionFooter({required this.isExpanded});

  AppController get controller => AppController.instance;

  @override
  Widget build(BuildContext context) {
    if (!isExpanded) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      width: context.width,
      child: Center(
        child: Obx(
          () => CustomAppVersion(
            prefix: 'V.',
            showVersionCode: controller.showVersionCode.value,
            showStroke: false,
            fontSize: 12.sp,
            textStyle: context.styles.textXs.copyWith(
              color: context.isDarkMode ? context.colors.mutedForeground : AppColors.slate.slate900,
              fontWeight: FontWeight.w400,
              height: 1.33,
            ),
          ),
        ),
      ),
    );
  }
}
