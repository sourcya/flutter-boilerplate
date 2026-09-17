part of '../../../ui.dart';

class BuildModalPreviousButton extends StatelessWidget {
  final RxBool? showPreviousButton;
  final VoidCallback? onPressed;

  const BuildModalPreviousButton({
    this.showPreviousButton,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (onPressed == null || showPreviousButton == null) {
      return const SizedBox.shrink();
    }

    return Obx(() {
      return showPreviousButton!.value
          ? IconButton(
              padding: context.paddingSymmetric(horizontal: 8, vertical: 8),
              visualDensity: VisualDensity.comfortable,
              icon: Icon(Icons.adaptive.arrow_back),
              onPressed: onPressed,
            )
          : const SizedBox.shrink();
    });
  }
}
