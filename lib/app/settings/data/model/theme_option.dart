part of '../../ui/imports/settings_imports.dart';

/// Represents the three visual theme choices exposed in the Settings UI.
enum ThemeOption {
  system,
  light,
  dark;

  ThemeMode get themeMode => switch (this) {
    ThemeOption.system => ThemeMode.system,
    ThemeOption.light => ThemeMode.light,
    ThemeOption.dark => ThemeMode.dark,
  };

  String get label => switch (this) {
    ThemeOption.system => AppTrans.system,
    ThemeOption.light => AppTrans.lightThemeShortLabel,
    ThemeOption.dark => AppTrans.darkThemeShortLabel,
  };

  IconData get icon => switch (this) {
    ThemeOption.system => Icons.brightness_auto_outlined,
    ThemeOption.light => Icons.light_mode_outlined,
    ThemeOption.dark => Icons.dark_mode_outlined,
  };

  Widget get previewWidget => switch (this) {
    ThemeOption.system => const _SystemThemePreview(),
    ThemeOption.light => const _LightThemePreview(),
    ThemeOption.dark => const _DarkThemePreview(),
  };
}

/// System: split light/dark halves with overlapping mock cards (Figma).
class _SystemThemePreview extends StatelessWidget {
  const _SystemThemePreview();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SystemThemeHalfPreview(
            isDark: false,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.r),
              bottomLeft: Radius.circular(8.r),
            ),
            cardOffsetX: 8,
          ),
        ),
        Expanded(
          child: _SystemThemeHalfPreview(
            isDark: true,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.r),
              bottomRight: Radius.circular(8.r),
            ),
            cardOffsetX: -88,
          ),
        ),
      ],
    );
  }
}

class _SystemThemeHalfPreview extends StatelessWidget {
  const _SystemThemeHalfPreview({
    required this.isDark,
    required this.borderRadius,
    required this.cardOffsetX,
  });

  final bool isDark;
  final BorderRadius borderRadius;
  final double cardOffsetX;

  @override
  Widget build(BuildContext context) {
    final surface = isDark ? const Color(0xFF020617) : const Color(0xFFE2E8F0);
    final cardBg = isDark ? const Color(0xFF1E293B) : Colors.white;
    final barColor = isDark ? const Color(0xFF94A3B8) : const Color(0xFFE2E8F0);

    return ClipRRect(
      borderRadius: borderRadius,
      child: ColoredBox(
        color: surface,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: cardOffsetX.r,
              top: 8.r,
              child: _ThemePreviewBarsCard(
                width: 176,
                bgColor: cardBg,
                barColor: barColor,
              ),
            ),
            Positioned(
              left: cardOffsetX.r,
              top: 56.r,
              child: _ThemePreviewRowCard(
                width: 176,
                height: 32,
                bgColor: cardBg,
                barColor: barColor,
                dotColor: barColor,
              ),
            ),
            Positioned(
              left: cardOffsetX.r,
              top: 96.r,
              child: _ThemePreviewRowCard(
                width: 176,
                height: 32,
                bgColor: cardBg,
                barColor: barColor,
                dotColor: barColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Light / Dark: padded surface with three stacked cards (Figma).
class _LightThemePreview extends StatelessWidget {
  const _LightThemePreview();

  @override
  Widget build(BuildContext context) {
    return const _FullThemePreview(isDark: false);
  }
}

class _DarkThemePreview extends StatelessWidget {
  const _DarkThemePreview();

  @override
  Widget build(BuildContext context) {
    return const _FullThemePreview(isDark: true);
  }
}

class _FullThemePreview extends StatelessWidget {
  const _FullThemePreview({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final surface = isDark ? const Color(0xFF020617) : const Color(0xFFE2E8F0);
    final cardBg = isDark ? const Color(0xFF1E293B) : Colors.white;
    final barColor = isDark ? const Color(0xFF94A3B8) : const Color(0xFFE2E8F0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: ColoredBox(
        color: surface,
        child: Padding(
          padding: context.paddingAll(8),
          child: Column(
            children: [
              Expanded(
                child: _ThemePreviewBarsCard(
                  bgColor: cardBg,
                  barColor: barColor,
                  compact: true,
                ),
              ),
              6.hBox,
              Expanded(
                child: _ThemePreviewRowCard(
                  bgColor: cardBg,
                  barColor: barColor,
                  dotColor: barColor,
                  compact: true,
                ),
              ),
              6.hBox,
              Expanded(
                child: _ThemePreviewRowCard(
                  bgColor: cardBg,
                  barColor: barColor,
                  dotColor: barColor,
                  compact: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemePreviewBarsCard extends StatelessWidget {
  const _ThemePreviewBarsCard({
    required this.bgColor,
    required this.barColor,
    this.width,
    this.compact = false,
  });

  final Color bgColor;
  final Color barColor;
  final double? width;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final padding = compact ? 6.0 : 8.0;
    final barGap = compact ? 6.0 : 8.0;

    return Container(
      width: width?.r ?? double.infinity,
      padding: context.paddingAll(padding),
      decoration: ShapeDecoration(
        color: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
        shadows: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80.r,
                  height: 8.r,
                  decoration: ShapeDecoration(
                    color: barColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                SizedBox(height: barGap.r),
                Container(
                  width: 100.r,
                  height: 8.r,
                  decoration: ShapeDecoration(
                    color: barColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ThemePreviewRowCard extends StatelessWidget {
  const _ThemePreviewRowCard({
    required this.bgColor,
    required this.barColor,
    required this.dotColor,
    this.width,
    this.height,
    this.compact = false,
  });

  final Color bgColor;
  final Color barColor;
  final Color dotColor;
  final double? width;
  final double? height;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final padding = compact ? 6.0 : 8.0;

    return Container(
      width: width?.r ?? double.infinity,
      height: height?.r,
      padding: context.paddingAll(padding),
      decoration: ShapeDecoration(
        color: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
        shadows: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 16.r,
              height: 16.r,
              decoration: ShapeDecoration(
                color: dotColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999.r),
                ),
              ),
            ),
            SizedBox(width: 8.r),
            Container(
              width: 100.r,
              height: 8.r,
              decoration: ShapeDecoration(
                color: barColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension ThemeModeSettingsExtension on ThemeMode {
  String get label => switch (this) {
    ThemeMode.system => AppTrans.system,
    ThemeMode.light => AppTrans.lightThemeShortLabel,
    ThemeMode.dark => AppTrans.darkThemeShortLabel,
  };

  IconData get icon => switch (this) {
    ThemeMode.system => Icons.brightness_auto_outlined,
    ThemeMode.light => Icons.light_mode_outlined,
    ThemeMode.dark => Icons.dark_mode_outlined,
  };
}
