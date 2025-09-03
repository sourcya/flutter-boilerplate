part of '../../../ui.dart';

class BuildModalCloseButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const BuildModalCloseButton({
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 8.r),
      visualDensity: VisualDensity.comfortable,
      icon: Icon(
        Icons.close,
        color: context.colors.onSurface,
      ),
      onPressed: onPressed,
    );
  }
}
