part of '../../ui.dart';

/// Column Header Widget
class ColumnHeader extends StatelessWidget {
  final String label;
  final IconInfo? icon;

  const ColumnHeader({super.key, required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            icon!.buildIconWidget(
              size: 14.0.r,
              color: context.colors.subtitleTextColor,
            ),
            SizedBox(width: 4.0.r),
          ],
          Flexible(
            child: CustomText(
              label.tr(context: context).capitalizeFirstCharForEachWord,
              textStyle: context.labelLargeTS.copyWith(
                color: context.colors.subtitleTextColor,
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              ),
              maxLines: 1,
              textOverflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
