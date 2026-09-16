part of '../../../imports/settings_imports.dart';

enum ThemeModeSelectorLayout { mobile, web }

/// Figma web theme chip size (Madaan: 164×164 with 24px gap).
const double _kWebThemeChipSize = 164;

/// Shared theme picker row (mobile portrait and landscape/web).
class ThemeModeSelectorWidget extends StatelessWidget {
  const ThemeModeSelectorWidget({
    super.key,
    required this.selectedTheme,
    required this.onThemeSelected,
    this.selectorLayout = ThemeModeSelectorLayout.web,
  });

  final ThemeMode selectedTheme;
  final ValueChanged<ThemeMode> onThemeSelected;
  final ThemeModeSelectorLayout selectorLayout;

  double get _chipGap => selectorLayout == ThemeModeSelectorLayout.mobile ? 16 : 24;

  static double get _webChipSize => _kWebThemeChipSize.clampedR;

  @override
  Widget build(BuildContext context) {
    final isWeb = selectorLayout == ThemeModeSelectorLayout.web;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: isWeb ? MainAxisSize.min : MainAxisSize.max,
      children: [
        for (int i = 0; i < ThemeMode.values.length; i++) ...[
          if (i > 0) _chipGap.wBox,
          if (isWeb)
            SizedBox(
              width: _webChipSize,
              child: ThemeModeChipWidget(
                mode: ThemeMode.values[i],
                isSelected: selectedTheme == ThemeMode.values[i],
                onTap: () => onThemeSelected(ThemeMode.values[i]),
                layout: selectorLayout,
              ),
            )
          else
            Expanded(
              child: ThemeModeChipWidget(
                mode: ThemeMode.values[i],
                isSelected: selectedTheme == ThemeMode.values[i],
                onTap: () => onThemeSelected(ThemeMode.values[i]),
                layout: selectorLayout,
              ),
            ),
        ],
      ],
    );
  }
}

class ThemeModeChipWidget extends StatelessWidget {
  const ThemeModeChipWidget({
    super.key,
    required this.mode,
    required this.isSelected,
    required this.onTap,
    this.layout = ThemeModeSelectorLayout.web,
  });

  final ThemeMode mode;
  final bool isSelected;
  final VoidCallback onTap;
  final ThemeModeSelectorLayout layout;

  bool get _isMobile => layout == ThemeModeSelectorLayout.mobile;

  double get _webChipSize => _kWebThemeChipSize.clampedR;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final borderColor = isSelected ? colors.primary : colors.muted;
    final outerRadius = _isMobile ? 8.r : 12.r;
    final innerRadius = _isMobile ? 4.r : 8.r;
    final borderWidth = _isMobile ? 1.r : 2.r;
    final checkOffset = _isMobile ? 4.r : 8.r;
    final checkPadding = _isMobile ? 2.0 : 4.0;
    final checkIconSize = _isMobile ? 8.r : 12.r;

    // Preview frame: web cards are square (1:1) to match the Figma. Mobile
    // keeps the existing fixed-height (80) rectangle.
    final previewFrame = Container(
      width: context.width,
      padding: context.paddingAll(4),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: borderWidth),
        borderRadius: BorderRadius.circular(outerRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(innerRadius),
        child: _ThemeModePreview(
          mode: mode,
          isMobile: _isMobile,
        ),
      ),
    );

    return Semantics(
      button: true,
      selected: isSelected,
      label: '${mode.label} theme',
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(outerRadius),
                child: _isMobile
                    ? SizedBox(height: 80.r, child: previewFrame)
                    : SizedBox(height: _webChipSize, child: previewFrame),
              ),
              if (isSelected)
                Positioned(
                  top: -checkOffset,
                  right: -checkOffset,
                  child: Container(
                    padding: context.paddingAll(checkPadding),
                    decoration: BoxDecoration(
                      color: colors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: IconInfo.icon(
                      Icons.check,
                      size: checkIconSize,
                      color: colors.primaryActionText,
                    ).buildIconWidget(),
                  ),
                ),
            ],
          ),
          6.hBox,
          CustomText(
            mode.label,
            textAlign: TextAlign.center,
            fontSize: _isMobile ? 12.sp : 14.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            height: _isMobile ? 1.33 : 1.43,
            color: colors.cardForeground,
          ),
        ],
      ),
    );
  }
}

class _ThemeModePreview extends StatelessWidget {
  final ThemeMode mode;
  final bool isMobile;

  const _ThemeModePreview({
    required this.mode,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final preview = WebThemePreview(mode: mode);
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          height: isMobile ? 136.r : 150.r,
          width: isMobile ? 120.r : 164.r,
          child: preview,
        ),
      ),
    );
  }
}
