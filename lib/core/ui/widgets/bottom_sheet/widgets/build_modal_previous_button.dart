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
              padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 8.r),
              visualDensity: VisualDensity.comfortable,
              icon: Icon(
                PlayxPlatform.isCupertino
                    ? CupertinoIcons.back
                    : Icons.arrow_back,
                color: context.colors.onSurface,
              ),
              onPressed: onPressed,
            )
          : const SizedBox.shrink();
    });
  }
}
