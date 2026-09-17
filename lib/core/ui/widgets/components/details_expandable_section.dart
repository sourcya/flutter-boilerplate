part of '../../ui.dart';

/// Map info section title with an expand/collapse chevron.
class DetailsExpandableSection extends StatelessWidget {
  final String title;
  final Widget child;
  final bool isExpanded;
  final VoidCallback onToggle;

  const DetailsExpandableSection({
    super.key,
    required this.title,
    required this.child,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
            onToggle();
          },
          child: Row(
            spacing: 8.r,
            children: [
              Expanded(
                child: CustomText(
                  title,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: colors.cardForeground,
                  height: 1,
                  isTranslatable: false,
                ),
              ),
              AnimatedRotation(
                turns: isExpanded ? 0.5 : 0,
                duration: 200.milliseconds,
                child: IconInfo.icon(
                  Icons.keyboard_arrow_down_rounded,
                ).buildIconWidget(
                  size: 16.r,
                  color: colors.cardForeground,
                ),
              ),
            ],
          ),
        ),
        AnimatedSize(
          duration: 200.milliseconds,
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: isExpanded
              ? Padding(
                  padding: context.paddingOnly(top: 16.0),
                  child: child,
                )
              : SizedBox(width: context.width),
        ),
      ],
    );
  }
}
