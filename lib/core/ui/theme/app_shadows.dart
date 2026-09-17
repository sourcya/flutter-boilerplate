part of '../ui.dart';

/// Shared [BoxShadow] definitions for consistent elevation across the app.
final class AppShadows {
  AppShadows._();

  /// Surface shadow for compact pills and outlined actions (login toolbar, cards).
  static List<BoxShadow> surfaceShadow(Color shadowColor) => [
    BoxShadow(
      color: shadowColor,
      blurRadius: 2,
      offset: const Offset(0, 1),
      spreadRadius: -1,
    ),
    BoxShadow(
      color: shadowColor,
      blurRadius: 3,
      offset: const Offset(0, 1),
    ),
  ];

  /// Single subtle shadow (e.g. help contact chips).
  static List<BoxShadow> subtleShadow(Color shadowColor) => [
    BoxShadow(
      color: shadowColor,
      blurRadius: 2,
      offset: const Offset(0, 1),
    ),
  ];

  /// Compact chip shadow matching login onboarding “Need Help” actions.
  static const List<BoxShadow> helpChipShadow = [
    BoxShadow(
      color: Color(0x0C000000),
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];

  /// Primary filled action / portrait FAB (Figma dual elevation).
  static List<BoxShadow> primaryAction(BuildContext context) {
    final shadowColor = context.colors.cardForeground.withValues(alpha: 0.1);
    return [
      BoxShadow(
        color: shadowColor,
        blurRadius: 6,
        offset: const Offset(0, 4),
        spreadRadius: -4,
      ),
      BoxShadow(
        color: shadowColor,
        blurRadius: 15,
        offset: const Offset(0, 10),
        spreadRadius: -3,
      ),
    ];
  }

  /// Drawer/Card shadow style (FAB, floating buttons)
  static List<BoxShadow> drawer(BuildContext context) => [
    BoxShadow(
      color: context.colors.cardShadowColor,
      blurRadius: 6,
      offset: const Offset(0, 4),
      spreadRadius: -4,
    ),
    BoxShadow(
      color: context.colors.cardShadowColor,
      blurRadius: 15,
      offset: const Offset(0, 10),
      spreadRadius: -3,
    ),
  ];

  /// Card shadow style (popup menus, dropdowns)
  static List<BoxShadow> card(BuildContext context) => [
    BoxShadow(
      color: context.colors.cardShadowColor,
      blurRadius: 4,
      offset: const Offset(0, 2),
      spreadRadius: -2,
    ),
    BoxShadow(
      color: context.colors.cardShadowColor,
      blurRadius: 6,
      offset: const Offset(0, 4),
      spreadRadius: -1,
    ),
  ];

  /// Dialog shadow style (landscape popups)
  static List<BoxShadow> dialog(BuildContext context) => [
    BoxShadow(
      color: context.colors.cardShadowColor,
      blurRadius: 4,
      offset: const Offset(0, 2),
      spreadRadius: -2,
    ),
    BoxShadow(
      color: context.colors.cardShadowColor,
      blurRadius: 6,
      offset: const Offset(0, 4),
      spreadRadius: -1,
    ),
  ];

  /// Map type popover container (Figma fixed elevation).
  static const List<BoxShadow> mapTypePopoverContainer = [
    BoxShadow(
      color: Color(0x19000000),
      blurRadius: 4,
      offset: Offset(0, 2),
      spreadRadius: -2,
    ),
    BoxShadow(
      color: Color(0x19000000),
      blurRadius: 6,
      offset: Offset(0, 4),
      spreadRadius: -1,
    ),
  ];

  /// Primary selection ring on map type thumbnails (black + white halo).
  static const List<BoxShadow> mapTypeSelectionRing = [
    BoxShadow(
      spreadRadius: 3,
    ),
    BoxShadow(
      color: AppColors.basewhite,
      spreadRadius: 1,
    ),
  ];

  /// Soft elevation for floating support (WhatsApp) buttons.
  static List<BoxShadow> supportButton(BuildContext context) {
    final primary = context.colors.primary;
    return [
      BoxShadow(
        color: primary.withValues(alpha: 0.28),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
      BoxShadow(
        color: primary.withValues(alpha: 0.12),
        blurRadius: 2,
        offset: const Offset(0, 1),
      ),
    ];
  }

  /// Bottom sheet shadow style (portrait popups)
  static List<BoxShadow> bottomSheet(BuildContext context) => [
    BoxShadow(
      color: context.colors.cardShadowColor,
      blurRadius: 6,
      offset: const Offset(0, -4),
      spreadRadius: -4,
    ),
    BoxShadow(
      color: context.colors.cardShadowColor,
      blurRadius: 15,
      offset: const Offset(0, -10),
      spreadRadius: -3,
    ),
  ];
}
