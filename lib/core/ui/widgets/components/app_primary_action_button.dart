part of '../../ui.dart';

/// Primary CTA with add icon (create entity, create job, etc.).
class AppPrimaryActionButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isPortraitStyle;

  const AppPrimaryActionButton({
    super.key,
    required this.title,
    this.onPressed,
    this.isPortraitStyle = true,
  });

  const AppPrimaryActionButton.fab({
    super.key,
    required this.title,
    this.onPressed,
  }) : isPortraitStyle = true;

  @override
  Widget build(BuildContext context) {
    if (isPortraitStyle) {
      return FloatingActionButton.extended(
        onPressed: onPressed,
        label: CustomText(
          title,
          textStyle: context.styles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            height: 1.71,
            color: context.colors.onPrimary,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: 12.radius),
        backgroundColor: context.colors.primary,
        icon: IconInfo.svg(
          Asset.icons.plus,
          color: context.colors.onPrimary,
          size: 16.r,
        ).buildIconWidget(),
      );
    }
    return ActionButton(
      title: title,
      onPressed: onPressed,
      backgroundColor: context.colors.primary,
      foregroundColor: context.colors.onPrimary,
      icon: IconInfo.svg(
        Asset.icons.plus,
        color: context.colors.onPrimary,
        size: 16.r,
      ).buildIconWidget(),
      borderRadius: 12.radius,
      padding: context.paddingSymmetric(
        horizontal: isPortraitStyle ? 24 : 16,
        vertical: isPortraitStyle ? 12 : 8,
      ),
      constraints: BoxConstraints(
        minWidth: 64.r,
        minHeight: isPortraitStyle ? 0 : 40.r,
      ),
      height: isPortraitStyle ? null : 40.r,
      shadows: isPortraitStyle ? AppShadows.primaryAction(context) : null,
      textStyle: context.styles.bodyMedium.copyWith(
        fontWeight: FontWeight.w600,
        height: 1.71,
        color: context.colors.onPrimary,
      ),
      iconSpace: 4,
      isIconPositionLeft: true,
    );
  }
}
