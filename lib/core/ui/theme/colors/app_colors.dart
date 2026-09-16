part of '../../ui.dart';

/// Design tokens shared by light and dark themes.
/// Brand colors follow Rehla Operator (`RehlaColorTokens`).
abstract class AppColors extends PlayxColors {
  final ColorScheme colorScheme;

  AppColors({
    required this.colorScheme,
  }) : super.fromColorScheme(scheme: colorScheme);

  Color get appBar;
  Color get onAppBar;
  Color? get subtitleTextColor;
  Color? get chipBackgroundColor;
  Color? get onChipBackgroundColor;
  Color? get buttonBackgroundColor;
  Color? get onButtonColor;
  Color? get bottomBarUnselectedColor;
  Color? get bottomBarShadowColor;
  Color? get disabledButtonBackgroundColor;
  Gradient? get backgroundGradient;
  Color get onBackgroundGradient;

  Color get background;
  Color get foreground;
  Color get muted;
  Color get mutedForeground;
  Color get cardBackgroundColor;
  Color get cardBorderColor;
  Color get cardShadowColor;
  Color get sidebarBackground;
  Color get sidebarForeground;
  Color get sidebarForeground70;
  Color get sidebarBorder;
  Color get sidebarPrimary;
  Color get sidebarPrimaryForeground;
  Color get sidebarRailDivider;
  Color get loginBackgroundBox;
  Color get loginCardBackground;
  Color get surfaceBackgroundColor;
  Color get actionButtonBackground;
  Color get actionButtonBorder;
  Color get bgMuted50;
  Color get bgMuted40 => bgMuted50;
  Color get authPageBackground => background;
  Color get authPanelBackground => cardBackgroundColor;
  Color get authLogoForeground => primary;
  Color get statusInactiveColor => RedColorTokens.c600;
  static const NeutralPalette slate = NeutralPalette();
  static const Color destructive = semanticDestructive;
  static const Color slate700 = SlateColorTokens.c700;
  static const Color slate900 = SlateColorTokens.c900;
  Color get inputBorderColor;
  Color get inputBackgroundColor;
  Color get inputTextColor;
  Color get inputHintColor;
  Color get gradientLoginEnd;
  Color get primaryActionText;
  Color get borderColor;
  Color get border => borderColor;
  Color get overlayBackground => SlateColorTokens.c950;
  Color get modalBarrier => overlayBackground.withValues(alpha: 0.45);
  Color get settingsSoftPrimaryChipFill => primaryContainer;
  Color get elevatedSurface => cardBackgroundColor;
  Color get sidePanelPageBackground => surface;
  Color get sidePanelContentSurface => cardBackgroundColor;
  Color get sidePanelInnerSurface => muted;
  Color get settingsChipSurface => RehlaColorTokens.primary50;
  Color get primaryOutlineBorder => RehlaColorTokens.primary200;
  Color get pickerSheetBackground => cardColor;
  Color get pickerSheetOptionSurface => muted;
  Color get toggleDividerColor => SlateColorTokens.c200;
  Color get toggleShadowColor => const Color(0x0C000000);
  Color get infoCardBackground => muted;

  Color get cardColor => cardBackgroundColor;
  Color get screenCardSurface => cardBackgroundColor;
  Color get cardForeground => foreground;
  Color get semanticBlue => BlueColorTokens.c600;
  Color get semanticGreen => colorScheme.brightness == Brightness.dark
      ? GreenColorTokens.c400
      : GreenColorTokens.c600;
  Color get settingsSubscriptionIconBackground =>
      colorScheme.brightness == Brightness.dark
          ? RehlaColorTokens.secondary900
          : RehlaColorTokens.secondaryBrand;
  Color get deleteButtonBorderColor => RedColorTokens.c100;
  Color get settingsSegmentSelectedFill => muted;
  Color? get loginDisabledColor => SlateColorTokens.c300;
  Color get black => baseblack;
  Color get white => basewhite;
  Color get accentForeground => onSurface;
  Color get onDoneColor => basewhite;

  static const Color baseblack = BaseColorTokens.black;
  static const Color basewhite = BaseColorTokens.white;
  static const Color semanticDestructive = RedColorTokens.c600;
  static const Color stepperAccent = RehlaColorTokens.primaryBrand;
  static const Color stepperIndicatorSurface = BaseColorTokens.white;
  static const Color stepperCompletedIcon = BaseColorTokens.white;
  static const PrimaryPalette primaryPalette = PrimaryPalette();

  static const Color blueGrey = Color(0xFF728295);
  static const Color blue = Colors.blue;
  static const Color primaryKey = RehlaColorTokens.primaryBrand;
  static const Color brandPrimary = RehlaColorTokens.primaryBrand;
  static const Color transparent = BaseColorTokens.transparent;
  static const Color input = SlateColorTokens.c200;
  static const Color slate50 = SlateColorTokens.c50;
  static const Color slate200 = SlateColorTokens.c200;
  static const Color slate300 = SlateColorTokens.c300;
  static const Color slate500 = SlateColorTokens.c500;
  static const Color slate950 = SlateColorTokens.c950;

  /// Brand gradient used on splash and primary CTAs (secondary700 → primary950).
  static const Gradient splashGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      RehlaColorTokens.secondary700,
      RehlaColorTokens.primary950,
    ],
  );

  static Gradient gradient({
    AlignmentGeometry begin = Alignment.center,
    AlignmentGeometry end = Alignment.bottomRight,
    BuildContext? context,
  }) {
    return LinearGradient(
      begin: begin,
      end: end,
      colors: const [
        RehlaColorTokens.secondary700,
        RehlaColorTokens.primary950,
      ],
    );
  }
}

class NeutralPalette {
  const NeutralPalette();

  static const Color n0 = BaseColorTokens.black;
  static const Color n10 = SlateColorTokens.c950;
  static const Color n20 = SlateColorTokens.c900;
  static const Color n30 = SlateColorTokens.c800;
  static const Color n40 = SlateColorTokens.c700;
  static const Color n50 = SlateColorTokens.c600;
  static const Color n60 = SlateColorTokens.c500;
  static const Color n70 = SlateColorTokens.c400;
  static const Color n80 = SlateColorTokens.c300;
  static const Color n90 = SlateColorTokens.c200;
  static const Color n95 = SlateColorTokens.c100;
  static const Color n99 = SlateColorTokens.c50;
  static const Color n100 = BaseColorTokens.white;

  Color get slate100 => n95;
  Color get slate700 => n40;
  Color get slate900 => n20;
}

class PrimaryPalette {
  const PrimaryPalette();

  static const Color p0 = BaseColorTokens.black;
  static const Color p10 = RehlaColorTokens.primary950;
  static const Color p20 = RehlaColorTokens.primary900;
  static const Color p30 = RehlaColorTokens.primary800;
  static const Color p40 = RehlaColorTokens.primary700;
  static const Color p50 = RehlaColorTokens.primary600;
  static const Color p60 = RehlaColorTokens.primary600;
  static const Color p70 = RehlaColorTokens.primary500;
  static const Color p80 = RehlaColorTokens.primary300;
  static const Color p90 = RehlaColorTokens.primary100;
  static const Color p95 = RehlaColorTokens.primary50;
  static const Color p99 = RehlaColorTokens.primary50;
  static const Color p100 = BaseColorTokens.white;

  Color get primary950 => p10;
  Color get primary900 => p10;
  Color get primary800 => p20;
  Color get primary700 => p30;
  Color get primary600 => p50;
  Color get primary500 => p60;
  Color get primary400 => p70;
  Color get primary300 => p80;
  Color get primary200 => p90;
  Color get primary100 => p95;
  Color get primary50 => p99;
}

class ErrorPalette {
  const ErrorPalette();

  static const Color e0 = BaseColorTokens.black;
  static const Color e20 = RedColorTokens.c900;
  static const Color e30 = RedColorTokens.c800;
  static const Color e60 = RedColorTokens.c500;
  static const Color e80 = RedColorTokens.c300;
  static const Color e90 = RedColorTokens.c200;
  static const Color e95 = RedColorTokens.c100;
  static const Color e100 = BaseColorTokens.white;
}

extension AppColorsExtension on BuildContext {
  AppColors get colors => playxColors as AppColors;
}
