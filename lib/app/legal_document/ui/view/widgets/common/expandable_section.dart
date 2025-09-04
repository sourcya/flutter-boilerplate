part of '../../../imports/legal_imports.dart';

class ExpandableSection extends StatelessWidget {
  final LegalSection section;
  final bool isExpanded;
  final VoidCallback onToggle;
  final int depth;

  const ExpandableSection({
    super.key,
    required this.section,
    required this.isExpanded,
    required this.onToggle,
    this.depth = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedLegalCard(
      index: section.order,
      isExpanded: isExpanded,
      onTap: onToggle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (depth > 0) SizedBox(width: (depth * 16).w),
              Expanded(
                child: CustomText(
                  section.title,
                  fontSize: (18 - depth * 2).sp,
                  fontWeight: FontWeight.w600,
                  color: context.colors.onSurface,
                ),
              ),
              AnimatedRotation(
                turns: isExpanded ? 0.5 : 0,
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  size: 24.r,
                  color: context.colors.primary,
                ),
              ),
            ],
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: EdgeInsets.only(top: 12.h, left: (depth * 16).w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    section.content,
                    textStyle: TextStyle(
                      fontSize: 14.sp,
                      height: 1.5,
                      color: context.colors.onSurface.withValues(alpha: 0.8),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 100.ms)
                      .slideY(begin: -0.1, end: 0, duration: 400.ms),
                  if (section.subSections.isNotEmpty)
                    ...section.subSections.map(
                      (subSection) => ExpandableSection(
                        section: subSection,
                        isExpanded: false,
                        onToggle: () {},
                        depth: depth + 1,
                      ),
                    ),
                ],
              ),
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
            sizeCurve: Curves.easeInOut,
          ),
        ],
      ),
    );
  }
}
