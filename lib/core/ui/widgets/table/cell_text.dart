part of '../../ui.dart';

/// Cell Text Widget
class CellText extends StatelessWidget {
  final String text;
  final String? subtitle;

  const CellText(this.text, {super.key, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text,
            textStyle: context.bodySmallTS.copyWith(
              color: context.colors.onSurface,
              height: 1.67,
            ),
            maxLines: 1,
            textOverflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            fontWeight: subtitle != null ? FontWeight.w600 : FontWeight.w400,
            font: fontFamilyBasedOnText(text),
            fontSize: 13.sp,
          ),
          if (subtitle != null) ...[
            4.boxR,
            CustomText(
              subtitle!,
              textStyle: context.bodySmallTS.copyWith(
                color: context.colors.subtitleTextColor,
                height: 1.67,
                fontSize: 12.sp,
              ),
              maxLines: 1,
              textOverflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              font: fontFamilyBasedOnText(subtitle),
            ),
          ],
        ],
      ),
    );
  }
}
