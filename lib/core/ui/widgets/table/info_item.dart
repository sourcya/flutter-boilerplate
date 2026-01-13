part of '../../ui.dart';

/// Info Item - Displays a piece of information with an icon
class InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14.0.r, color: context.colors.onSurface),
            SizedBox(width: 4.0.r),
            Flexible(
              child: CustomText(
                label,
                textStyle: context.bodyMediumTS.copyWith(
                  color: context.colors.onSurface,
                ),
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0.r),
        CustomText(
          value,
          textStyle: context.titleMediumTS.copyWith(
            color: context.colors.onSurface,
            fontWeight: FontWeight.w600,
            fontFamily: fontFamilyBasedOnText(value),
            fontSize: 13.sp,
          ),
          maxLines: 2,
          textOverflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
