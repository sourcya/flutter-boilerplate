import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:playx/playx.dart';

import '../../components/custom_elevated_button.dart';
import '../custom_modal.dart';

class BuildModalNextButton extends StatelessWidget {
  final bool listenToUpdates;
  final Rx<StickyActionBarStatus> status;
  final VoidCallback? onPressed;

  const BuildModalNextButton({
    required this.status,
    this.onPressed,
    this.listenToUpdates = true,
  });

  @override
  Widget build(BuildContext context) {
    final button = listenToUpdates
        ? Obx(() {
            return _buildButton(
              status: status,
              onPressed: onPressed,
            );
          })
        : _buildButton(
            status: status,
            onPressed: onPressed,
          );

    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        if (isKeyboardVisible) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: EdgeInsets.only(bottom: 4.0.r),
          child: button,
        );
      },
    );
  }

  Widget _buildButton({
    required Rx<StickyActionBarStatus> status,
    VoidCallback? onPressed,
  }) {
    if (status.value == StickyActionBarStatus.none) {
      return const SizedBox.shrink();
    }

    final isEnabled = status.value != StickyActionBarStatus.disabled;
    final isLoading = status.value == StickyActionBarStatus.loading;
    final label = status.value.label;

    return CustomElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      isLoading: isLoading,
      margin: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 12.h,
      ),
      label: label,
    );
  }
}
