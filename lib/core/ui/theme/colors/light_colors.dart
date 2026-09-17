part of '../../ui.dart';

class LightColors extends AppColors {
  static const ColorScheme scheme = ColorScheme(
    brightness: Brightness.light,
    primary: RehlaColorTokens.primaryBrand,
    onPrimary: BaseColorTokens.white,
    primaryContainer: RehlaColorTokens.primary50,
    onPrimaryContainer: RehlaColorTokens.primary900,
    primaryFixed: RehlaColorTokens.primary50,
    onPrimaryFixed: RehlaColorTokens.primary950,
    primaryFixedDim: RehlaColorTokens.primary100,
    onPrimaryFixedVariant: RehlaColorTokens.primary800,
    secondary: RehlaColorTokens.secondaryBrand,
    onSecondary: BaseColorTokens.white,
    secondaryContainer: RehlaColorTokens.secondary50,
    onSecondaryContainer: RehlaColorTokens.secondary900,
    secondaryFixed: RehlaColorTokens.secondary50,
    onSecondaryFixed: RehlaColorTokens.secondary950,
    secondaryFixedDim: RehlaColorTokens.secondary100,
    onSecondaryFixedVariant: RehlaColorTokens.secondary800,
    tertiary: RehlaColorTokens.tertiaryBrand,
    onTertiary: RehlaColorTokens.tertiary950,
    tertiaryContainer: RehlaColorTokens.tertiary100,
    onTertiaryContainer: RehlaColorTokens.tertiary900,
    tertiaryFixed: RehlaColorTokens.tertiary100,
    tertiaryFixedDim: RehlaColorTokens.tertiary200,
    onTertiaryFixed: RehlaColorTokens.tertiary950,
    onTertiaryFixedVariant: RehlaColorTokens.tertiary800,
    error: ErrorPalette.e60,
    onError: ErrorPalette.e100,
    errorContainer: ErrorPalette.e95,
    onErrorContainer: ErrorPalette.e30,
    surface: NeutralPalette.n95,
    onSurface: NeutralPalette.n20,
    surfaceDim: NeutralPalette.n90,
    surfaceBright: NeutralPalette.n95,
    surfaceContainerLowest: NeutralPalette.n100,
    surfaceContainerLow: NeutralPalette.n99,
    surfaceContainer: NeutralPalette.n99,
    surfaceContainerHigh: NeutralPalette.n95,
    surfaceContainerHighest: NeutralPalette.n90,
    outline: NeutralPalette.n70,
    onSurfaceVariant: NeutralPalette.n50,
    outlineVariant: NeutralPalette.n80,
    inverseSurface: NeutralPalette.n30,
    onInverseSurface: NeutralPalette.n95,
    inversePrimary: RehlaColorTokens.primary300,
    shadow: NeutralPalette.n0,
    scrim: NeutralPalette.n0,
    surfaceTint: RehlaColorTokens.primary600,
  );

  LightColors() : super(colorScheme: scheme);

  @override
  Color get background => BaseColorTokens.white;

  @override
  Color get appBar => BaseColorTokens.white;

  @override
  Color get onAppBar => onSurface;

  @override
  Color? get chipBackgroundColor => Colors.grey;

  @override
  Color? get subtitleTextColor => SlateColorTokens.c500;

  @override
  Color? get buttonBackgroundColor => primary;

  @override
  Color? get onButtonColor => BaseColorTokens.white;

  @override
  Color? get bottomBarUnselectedColor => SlateColorTokens.c400;

  @override
  Color? get bottomBarShadowColor => SlateColorTokens.c300;

  @override
  Color? get onChipBackgroundColor => BaseColorTokens.white;

  @override
  Color? get disabledButtonBackgroundColor => SlateColorTokens.c300;

  @override
  Gradient? get backgroundGradient => AppColors.splashGradient;

  @override
  Color get onBackgroundGradient => BaseColorTokens.white;

  @override
  Color get foreground => SlateColorTokens.c950;

  @override
  Color get muted => SlateColorTokens.c100;

  @override
  Color get mutedForeground => SlateColorTokens.c500;

  @override
  Color get cardBackgroundColor => BaseColorTokens.white;

  @override
  Color get cardBorderColor => SlateColorTokens.c200;

  @override
  Color get cardShadowColor => const Color(0x19000000);

  @override
  Color get sidebarBackground => RehlaColorTokens.primaryBrand;

  @override
  Color get sidebarForeground => SlateColorTokens.c50;

  @override
  Color get sidebarForeground70 => const Color(0xB2F8FAFC);

  @override
  Color get sidebarBorder => RehlaColorTokens.primary800;

  @override
  Color get sidebarPrimary => AppColors.brandPrimary;

  @override
  Color get sidebarPrimaryForeground => SlateColorTokens.c50;

  @override
  Color get sidebarRailDivider => SlateColorTokens.c700;

  @override
  Color get loginBackgroundBox => BaseColorTokens.black.withValues(alpha: .4);

  @override
  Color get loginCardBackground => BaseColorTokens.white;

  @override
  Color get surfaceBackgroundColor => surface;

  @override
  Color get actionButtonBackground => BaseColorTokens.white;

  @override
  Color get actionButtonBorder => RehlaColorTokens.primary100;

  @override
  Color get bgMuted50 => const Color(0x7FF1F5F9);

  @override
  Color get bgMuted40 => const Color(0x66F1F5F9);

  @override
  Color get authPageBackground => BaseColorTokens.white;

  @override
  Color get inputBorderColor => AppColors.input;

  @override
  Color get inputBackgroundColor => BaseColorTokens.white;

  @override
  Color get inputTextColor => SlateColorTokens.c950;

  @override
  Color get inputHintColor => SlateColorTokens.c500;

  @override
  Color get gradientLoginEnd => RehlaColorTokens.primaryBrand;

  @override
  Color get primaryActionText => SlateColorTokens.c50;

  @override
  Color get borderColor => SlateColorTokens.c200;

  @override
  Color get deleteButtonBorderColor => RedColorTokens.c100;

  @override
  Color get semanticBlue => BlueColorTokens.c600;
}
