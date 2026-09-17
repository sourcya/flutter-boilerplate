part of '../../ui.dart';

class TableDataCell {
  const TableDataCell._();

  static DataCell clickable({
    required Widget child,
    VoidCallback? onTap,
    MouseCursor enabledCursor = SystemMouseCursors.click,
    MouseCursor disabledCursor = MouseCursor.defer,
  }) {
    return DataCell(
      onTap: onTap,
      MouseRegion(
        cursor: onTap != null ? enabledCursor : disabledCursor,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }

  static DataCell clickableText(
    BuildContext context, {
    required String text,
    VoidCallback? onTap,
    String? subtitle,
    bool isStart = true,
    bool isTranslatable = false,
    int maxLines = 1,
    CellTextPreset preset = CellTextPreset.accent,
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    double? lineHeight,
    TextOverflow textOverflow = TextOverflow.ellipsis,
    List<InlineSpan>? children,
    MouseCursor enabledCursor = SystemMouseCursors.click,
    MouseCursor disabledCursor = MouseCursor.defer,
  }) {
    final cellText = isStart
        ? CellText.start(
            text,
            subtitle: subtitle,
            preset: preset,
            color: color ?? (onTap != null ? context.colors.semanticBlue : null),
            fontWeight: fontWeight ?? (onTap != null ? FontWeight.w600 : null),
            fontSize: fontSize,
            lineHeight: lineHeight,
            maxLines: maxLines,
            textOverflow: textOverflow,
            isTranslatable: isTranslatable,
            isSelectable: false,
            children: children,
          )
        : CellText(
            text,
            subtitle: subtitle,
            preset: preset,
            color: color ?? (onTap != null ? context.colors.semanticBlue : null),
            fontWeight: fontWeight ?? (onTap != null ? FontWeight.w600 : null),
            fontSize: fontSize,
            lineHeight: lineHeight,
            maxLines: maxLines,
            textOverflow: textOverflow,
            isTranslatable: isTranslatable,
            isSelectable: false,
            children: children,
          );

    return clickable(
      onTap: onTap,
      enabledCursor: enabledCursor,
      disabledCursor: disabledCursor,
      child: cellText,
    );
  }
}
