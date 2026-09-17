part of '../../ui.dart';

/// Title + optional subtitle (list cards, details headers).
class CustomTitleMetaWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final double rowSpacing;
  final double titleFontSize;
  final double? titleLetterSpacing;
  final bool useDynamicTitleFont;
  final double subtitleFontSize;
  final double subtitleLineHeight;

  const CustomTitleMetaWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.rowSpacing = 4,
    this.titleFontSize = 16,
    this.titleLetterSpacing,
    this.useDynamicTitleFont = false,
    this.subtitleFontSize = 12,
    this.subtitleLineHeight = 1.67,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: rowSpacing,
      children: [
        CustomText(
          title,
          fontSize: titleFontSize.sp,
          fontWeight: FontWeight.w600,
          color: context.colors.cardForeground,
          letterSpacing: titleLetterSpacing,
          height: 1,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          isTranslatable: false,
          font: useDynamicTitleFont ? fontFamilyBasedOnText(title) : null,
        ),
        if (subtitle != null)
          CustomText(
            subtitle!,
            fontSize: subtitleFontSize.sp,
            fontWeight: FontWeight.w400,
            color: context.colors.mutedForeground,
            height: subtitleLineHeight,
            isTranslatable: false,
          ),
      ],
    );
  }
}
