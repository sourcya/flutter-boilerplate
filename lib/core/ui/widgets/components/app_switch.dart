part of '../../ui.dart';

/// A customizable adaptive switch widget that follows the app's design system.
///
/// Provides consistent styling across the app with support for:
/// - Dark/light mode colors
/// - Custom active/inactive colors
/// - Compact mode with shrink wrap
/// - Disabled state
class AppSwitch extends StatelessWidget {
  /// Whether the switch is on or off.
  final bool value;

  /// Called when the user toggles the switch.
  final ValueChanged<bool>? onChanged;

  /// The color to use for the switch's track when it is active.
  final Color? activeTrackColor;

  /// The color to use for the switch's thumb when it is inactive.
  final Color? inactiveThumbColor;

  /// The color to use for the switch's track when it is inactive.
  final Color? inactiveTrackColor;

  /// Configures the minimum size of the tap target.
  final MaterialTapTargetSize? materialTapTargetSize;

  /// Whether the switch is disabled.
  final bool isDisabled;

  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.materialTapTargetSize,
    this.isDisabled = false,
  });

  /// Creates a switch with default styling for the app.
  factory AppSwitch.defaultStyle({
    Key? key,
    required bool value,
    required ValueChanged<bool>? onChanged,
    bool isDisabled = false,
  }) {
    return AppSwitch(
      key: key,
      value: value,
      onChanged: isDisabled ? null : onChanged,
      isDisabled: isDisabled,
    );
  }

  /// Creates a switch with compact styling (shrink wrap).
  factory AppSwitch.compact({
    Key? key,
    required bool value,
    required ValueChanged<bool>? onChanged,
    bool isDisabled = false,
  }) {
    return AppSwitch(
      key: key,
      value: value,
      onChanged: isDisabled ? null : onChanged,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      isDisabled: isDisabled,
    );
  }

  /// Creates a switch with themed colors for dark/light mode.
  factory AppSwitch.themed({
    Key? key,
    required BuildContext context,
    required bool value,
    required ValueChanged<bool>? onChanged,
    bool isDisabled = false,
    Color? activeTrackColor,
    Color? inactiveThumbColor,
    Color? inactiveTrackColor,
  }) {
    return AppSwitch(
      key: key,
      value: value,
      onChanged: isDisabled ? null : onChanged,
      activeTrackColor: activeTrackColor ?? context.colors.primary,
      inactiveThumbColor:
          inactiveThumbColor ??
          (context.isDarkMode
              ? context.colors.colorScheme.onSurface
              : context.colors.colorScheme.surfaceContainerLowest),
      inactiveTrackColor:
          inactiveTrackColor ??
          (context.isDarkMode
              ? context.colors.colorScheme.surfaceContainer
              : context.colors.cardBorderColor),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      isDisabled: isDisabled,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      value: value,
      onChanged: isDisabled ? null : onChanged,
      activeTrackColor: activeTrackColor ?? context.colors.primary,
      inactiveThumbColor: inactiveThumbColor,
      inactiveTrackColor: inactiveTrackColor,
      materialTapTargetSize: materialTapTargetSize,
    );
  }
}
