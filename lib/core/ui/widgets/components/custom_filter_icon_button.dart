part of '../../ui.dart';

class CustomFilterIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool Function()? isSelected;

  const CustomFilterIconButton({
    super.key,
    required this.onPressed,
    this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final selected = isSelected?.call() == true;
    final backgroundColor = selected ? context.colors.primaryContainer : context.colors.cardColor;
    final foregroundColor = selected ? context.colors.onPrimaryContainer : context.colors.primary;

    return ActionButton.outlined(
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderColor: context.colors.primary.withValues(alpha: .3),
      borderRadius: 12.radius,
      padding: context.paddingAll(8),
      constraints: BoxConstraints.tightFor(width: 40.r, height: 40.r),
      icon: IconInfo.svg(
        Asset.icons.icFilter,
        color: foregroundColor,
        size: context.isAppPortrait ? (context.isMobile ? 16 : 20).r : 18.r,
      ).buildIconWidget(),
    );
  }
}
