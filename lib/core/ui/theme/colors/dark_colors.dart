part of '../../ui.dart';

class DarkColors extends AppColors {
  static const ColorScheme scheme = ColorScheme(
    brightness: Brightness.dark,
    primary: RehlaColorTokens.primary300,
    onPrimary: RehlaColorTokens.primary950,
    primaryContainer: RehlaColorTokens.primary800,
    onPrimaryContainer: RehlaColorTokens.primary100,
    primaryFixed: RehlaColorTokens.primary50,
    onPrimaryFixed: RehlaColorTokens.primary950,
    primaryFixedDim: RehlaColorTokens.primary300,
    onPrimaryFixedVariant: RehlaColorTokens.primary800,
    secondary: RehlaColorTokens.secondary300,
    onSecondary: RehlaColorTokens.secondary950,
    secondaryContainer: RehlaColorTokens.secondary800,
    onSecondaryContainer: RehlaColorTokens.secondary100,
    secondaryFixed: RehlaColorTokens.secondary50,
    onSecondaryFixed: RehlaColorTokens.secondary950,
    secondaryFixedDim: RehlaColorTokens.secondary300,
    onSecondaryFixedVariant: RehlaColorTokens.secondary800,
    tertiary: RehlaColorTokens.tertiary300,
    onTertiary: RehlaColorTokens.tertiary950,
    tertiaryContainer: RehlaColorTokens.tertiary800,
    onTertiaryContainer: RehlaColorTokens.tertiary100,
    error: ErrorPalette.e80,
    onError: ErrorPalette.e20,
    errorContainer: ErrorPalette.e30,
    onErrorContainer: ErrorPalette.e90,
    surface: NeutralPalette.n20,
    onSurface: NeutralPalette.n95,
    surfaceDim: NeutralPalette.n10,
    surfaceBright: NeutralPalette.n30,
    surfaceContainerLowest: NeutralPalette.n10,
    surfaceContainerLow: NeutralPalette.n20,
    surfaceContainer: NeutralPalette.n30,
    surfaceContainerHigh: NeutralPalette.n30,
    surfaceContainerHighest: NeutralPalette.n40,
    outline: NeutralPalette.n70,
    onSurfaceVariant: NeutralPalette.n80,
    outlineVariant: NeutralPalette.n50,
    inverseSurface: NeutralPalette.n90,
    onInverseSurface: NeutralPalette.n20,
    inversePrimary: RehlaColorTokens.primary600,
    shadow: NeutralPalette.n0,
    scrim: NeutralPalette.n0,
    surfaceTint: RehlaColorTokens.primary300,
  );

  DarkColors() : super(colorScheme: scheme);

  @override
  Color get background => SlateColorTokens.c950;

  @override
  Color get appBar => surface.withValues(alpha: .93);

  @override
  Color get onAppBar => BaseColorTokens.white;

  @override
  Color? get subtitleTextColor => SlateColorTokens.c400;

  @override
  Color? get chipBackgroundColor => SlateColorTokens.c700;

  @override
  Color? get buttonBackgroundColor => RehlaColorTokens.primary300;

  @override
  Color? get bottomBarUnselectedColor => SlateColorTokens.c500;

  @override
  Color? get onButtonColor => RehlaColorTokens.primary950;

  @override
  Color? get bottomBarShadowColor => Colors.transparent;

  @override
  Color? get onChipBackgroundColor => BaseColorTokens.white;

  @override
  Color? get disabledButtonBackgroundColor => SlateColorTokens.c600;

  @override
  Gradient? get backgroundGradient => AppColors.splashGradient;

  @override
  Color get onBackgroundGradient => BaseColorTokens.white;

  @override
  Color get foreground => SlateColorTokens.c50;

  @override
  Color get muted => SlateColorTokens.c800;

  @override
  Color get mutedForeground => SlateColorTokens.c400;

  @override
  Color get cardBackgroundColor => colorScheme.surfaceContainerHigh;

  @override
  Color get cardBorderColor => SlateColorTokens.c700;

  @override
  Color get cardShadowColor => const Color(0x19000000);

  @override
  Color get sidebarBackground => RehlaColorTokens.primaryBrand;

  @override
  Color get sidebarForeground => SlateColorTokens.c50;

  @override
  Color get sidebarForeground70 => const Color(0xB2F8FAFC);

  @override
  Color get sidebarBorder => SlateColorTokens.c800;

  @override
  Color get sidebarPrimary => AppColors.brandPrimary;

  @override
  Color get sidebarPrimaryForeground => SlateColorTokens.c50;

  @override
  Color get sidebarRailDivider => SlateColorTokens.c700;

  @override
  Color get loginBackgroundBox => BaseColorTokens.black.withValues(alpha: .5);

  @override
  Color get loginCardBackground => surface.withValues(alpha: .8);

  @override
  Color get surfaceBackgroundColor => bgMuted50;

  @override
  Color get actionButtonBackground => BaseColorTokens.black;

  @override
  Color get actionButtonBorder => RehlaColorTokens.primary300;

  @override
  Color get bgMuted50 => surface;

  @override
  Color get bgMuted40 => const Color(0x661E293B);

  @override
  Color get authPageBackground => surface;

  @override
  Color get inputBorderColor => SlateColorTokens.c800;

  @override
  Color get inputBackgroundColor => SlateColorTokens.c950;

  @override
  Color get inputTextColor => SlateColorTokens.c50;

  @override
  Color get inputHintColor => SlateColorTokens.c400;

  @override
  Color get gradientLoginEnd => RehlaColorTokens.primaryBrand;

  @override
  Color get primaryActionText => SlateColorTokens.c50;

  @override
  Color get borderColor => SlateColorTokens.c700;

  @override
  Color get deleteButtonBorderColor => RedColorTokens.c900;

  @override
  Color get semanticBlue => BlueColorTokens.c400;

  @override
  Color get overlayBackground => SlateColorTokens.c50;

  @override
  Color get elevatedSurface => surfaceContainerHigh;

  @override
  Color get sidePanelPageBackground => surface;

  @override
  Color get sidePanelContentSurface => surfaceContainerHigh;

  @override
  Color get sidePanelInnerSurface => surfaceContainerHighest;

  @override
  Color get settingsChipSurface =>
      RehlaColorTokens.primary800.withValues(alpha: 0.62);

  @override
  Color get primaryOutlineBorder => RehlaColorTokens.primary300;

  @override
  Color get toggleDividerColor => SlateColorTokens.c700;

  @override
  Color get infoCardBackground => bgMuted50;
}
