part of '../ui.dart';

class KeyboardVisibilityPadding extends StatelessWidget {
  const KeyboardVisibilityPadding();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isVisible) {
        return isVisible
            ? const SizedBox.shrink()
            : const SizedBox(height: Dimens.bottomNavBarHeight);
      },
    );
  }
}
