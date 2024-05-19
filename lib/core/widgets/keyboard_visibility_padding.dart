import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../resources/dimens/dimens.dart';

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
