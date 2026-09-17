part of '../../ui.dart';

/// Column Header Widget
class ColumnHeader extends StatelessWidget {
  final String label;
  final IconInfo? icon;
  final MainAxisAlignment alignment;
  final bool isSortable;
  final double? fontSize;
  final double? lineHeight;

  const ColumnHeader({
    super.key,
    required this.label,
    this.icon,
    this.alignment = MainAxisAlignment.center,
    this.fontSize = 14,
    this.lineHeight = 1.71,
  }) : isSortable = false;

  const ColumnHeader.start({
    super.key,
    required this.label,
    this.icon,
    this.fontSize = 14,
    this.lineHeight = 1.71,
  }) : alignment = MainAxisAlignment.start,
       isSortable = false;

  const ColumnHeader.sortable({
    super.key,
    required this.label,
    this.icon,
    this.alignment = MainAxisAlignment.center,
    this.fontSize = 14,
    this.lineHeight = 1.71,
  }) : isSortable = true;

  const ColumnHeader.startSortable({
    super.key,
    required this.label,
    this.icon,
    this.fontSize = 14,
    this.lineHeight = 1.71,
  }) : alignment = MainAxisAlignment.start,
       isSortable = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: alignment,
      children: [
        if (icon != null) ...[
          icon?.buildIconWidget(
                size: 16.0.r,
                color: context.colors.mutedForeground,
              ) ??
              const SizedBox.shrink(),
          4.0.wBox,
        ],
        Flexible(
          child: CustomText(
            label.tr(context: context).capitalizeFirstCharForEachWord,
            textAlign: alignment == MainAxisAlignment.start
                ? TextAlign.start
                : (alignment == MainAxisAlignment.end ? TextAlign.end : TextAlign.center),
            textStyle: context.labelLargeTS.copyWith(
              color: context.colors.mutedForeground,
              fontWeight: FontWeight.w600,
              fontSize: fontSize?.sp ?? 13.sp,
              height: lineHeight ?? 1.67,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (isSortable) ...[
          4.0.wBox,
          IconInfo.svg(Asset.icons.svgFilter).buildIconWidget(
            size: 16.0.r,
            color: context.colors.mutedForeground,
          ),
        ],
      ],
    );
  }
}
