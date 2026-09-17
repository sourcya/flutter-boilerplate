part of '../../../ui.dart';

class BuildModalNextButton extends StatelessWidget {
  final bool listenToUpdates;
  final Rx<StickyActionBarStatus> status;
  final VoidCallback? onPressed;
  final String? label;
  final bool hideOnKeyboardVisible;

  const BuildModalNextButton({
    required this.status,
    this.label,
    this.onPressed,
    this.listenToUpdates = true,
    this.hideOnKeyboardVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    final button = listenToUpdates
        ? Obx(() {
            return _buildButton(
              context: context,
              status: status,
              onPressed: onPressed,
              label: label,
            );
          })
        : _buildButton(
            context: context,
            label: label,
            status: status,
            onPressed: onPressed,
          );

    return hideOnKeyboardVisible
        ? KeyboardVisibilityBuilder(
            builder: (context, isKeyboardVisible) {
              if (isKeyboardVisible) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: context.paddingOnly(bottom: 4.0),
                child: button,
              );
            },
          )
        : Padding(
            padding: context.paddingOnly(bottom: 4.0),
            child: button,
          );
  }

  Widget _buildButton({
    required BuildContext context,
    String? label,
    required Rx<StickyActionBarStatus> status,
    VoidCallback? onPressed,
  }) {
    if (status.value == StickyActionBarStatus.none) {
      return const SizedBox.shrink();
    }

    final isEnabled = status.value != StickyActionBarStatus.disabled;
    final isLoading = status.value == StickyActionBarStatus.loading;
    final btnLabel = label ?? status.value.label;

    return CustomElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      isLoading: isLoading,
      margin: context.paddingSymmetric(horizontal: 8, vertical: 12),
      label: btnLabel,
    );
  }
}
