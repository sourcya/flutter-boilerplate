part of '../../ui.dart';

/// Info Item - Displays a piece of information with an icon
class InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final CrossAxisAlignment alignment;

  const InfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.alignment = CrossAxisAlignment.start,
  });
  const InfoItem.center({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  }) : alignment = CrossAxisAlignment.center;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Row(
          children: [
            Icon(icon, size: 14.0.r, color: context.colors.onSurface),
            4.0.wBox,
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
        8.0.hBox,
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
