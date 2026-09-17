part of '../../../ui.dart';

class BuildModalCloseButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const BuildModalCloseButton({
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: context.paddingSymmetric(horizontal: 8, vertical: 8),
      visualDensity: VisualDensity.comfortable,
      icon: Icon(
        Icons.close,
        color: context.colors.onSurface,
      ),
      onPressed: onPressed,
    );
  }
}
