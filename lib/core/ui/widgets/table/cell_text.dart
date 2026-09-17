part of '../../ui.dart';

enum CellTextPreset {
  standard,
  id,
  body,
  accent,
  muted,
}

/// Cell Text Widget
class CellText extends StatelessWidget {
  final String text;
  final String? subtitle;
  final int maxLines;
  final bool isStart;
  final Color? color;
  final FontWeight? fontWeight;
  final bool? isSelectable;
  final List<InlineSpan>? children;
  final CellTextPreset preset;
  final double? fontSize;
  final double? lineHeight;
  final TextOverflow textOverflow;
  final bool isTranslatable;

  const CellText(
    this.text, {
    super.key,
    this.subtitle,
    this.maxLines = 1,
    this.color,
    this.children,
    this.fontWeight,
    this.isStart = false,
    this.isSelectable,
    this.preset = CellTextPreset.standard,
    this.fontSize,
    this.lineHeight,
    this.textOverflow = TextOverflow.ellipsis,
    this.isTranslatable = true,
  });
  const CellText.start(
    this.text, {
    super.key,
    this.subtitle,
    this.maxLines = 1,
    this.color,
    this.children,
    this.fontWeight,
    this.isSelectable,
    this.preset = CellTextPreset.standard,
    this.fontSize,
    this.lineHeight,
    this.textOverflow = TextOverflow.ellipsis,
    this.isTranslatable = true,
  }) : isStart = true;

  ({double fontSize, double lineHeight, FontWeight fontWeight, Color? color}) _resolveStyle(
    BuildContext context,
  ) {
    switch (preset) {
      case CellTextPreset.id:
        return (
          fontSize: fontSize ?? 16.sp,
          lineHeight: lineHeight ?? 1.43,
          fontWeight: fontWeight ?? FontWeight.w600,
          color: color ?? context.colors.primary,
        );
      case CellTextPreset.body:
        return (
          fontSize: fontSize ?? 16.sp,
          lineHeight: lineHeight ?? 1.43,
          fontWeight: fontWeight ?? FontWeight.w400,
          color: color ?? context.colors.cardForeground,
        );
      case CellTextPreset.accent:
        return (
          fontSize: fontSize ?? 15.sp,
          lineHeight: lineHeight ?? 1.43,
          fontWeight: fontWeight ?? FontWeight.w600,
          color: color ?? context.colors.semanticBlue,
        );
      case CellTextPreset.muted:
        return (
          fontSize: fontSize ?? 14.sp,
          lineHeight: lineHeight ?? 1.43,
          fontWeight: fontWeight ?? FontWeight.w400,
          color: color ?? context.colors.mutedForeground,
        );
      case CellTextPreset.standard:
        return (
          fontSize: fontSize ?? 14.sp,
          lineHeight: lineHeight ?? 1.43,
          fontWeight: fontWeight ?? (subtitle != null ? FontWeight.w600 : FontWeight.w400),
          color: color,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final fullText = subtitle != null ? '$text\n$subtitle' : text;
    final resolvedStyle = _resolveStyle(context);

    final effectiveSelectable =
        isSelectable == true ||
        (kIsWeb &&
            WebTableSelectionScope.maybeOf(context) &&
            isSelectable == null &&
            preset != CellTextPreset.id);

    if (effectiveSelectable) {
      return CustomText(
        fullText,
        isSelectable: true,
        maxLines: maxLines,
        overflow: textOverflow,
        textAlign: isStart ? TextAlign.start : TextAlign.center,
        height: resolvedStyle.lineHeight,
        fontWeight: resolvedStyle.fontWeight,
        font: fontFamilyBasedOnText(text),
        fontSize: resolvedStyle.fontSize,
        color: resolvedStyle.color,
        isTranslatable: isTranslatable,
      );
    }

    return WebSelectableRichText(
      isSelectable: effectiveSelectable,
      maxLines: maxLines,
      overflow: textOverflow,
      textAlign: isStart ? TextAlign.start : TextAlign.center,
      text: TextSpan(
        children:
            children ??
            [
              TextSpan(
                text: text.tr(context: context),
                style: context.bodySmallTS.copyWith(
                  height: resolvedStyle.lineHeight,
                  fontWeight: resolvedStyle.fontWeight,
                  fontFamily: fontFamilyBasedOnText(text),
                  fontSize: resolvedStyle.fontSize,
                  color: resolvedStyle.color,
                ),
              ),
              if (subtitle != null) ...[
                const TextSpan(text: '\n'),
                TextSpan(
                  text: subtitle?.tr(context: context),
                  style: context.bodySmallTS.copyWith(
                    color: context.colors.mutedForeground,
                    height: 1.67,
                    fontFamily: fontFamilyBasedOnText(subtitle),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ],
      ),
    );
  }
}
