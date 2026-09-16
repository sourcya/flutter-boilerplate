part of '../../../imports/settings_imports.dart';

/// Stacks settings blocks with [spacing] between each child (Figma column gap: 24).
class WebSettingsSectionColumnWidget extends StatelessWidget {
  const WebSettingsSectionColumnWidget({
    super.key,
    required this.children,
    this.spacing = 24,
  });

  final List<Widget> children;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();

    final items = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      if (i > 0) items.add(spacing.hBox);
      items.add(children[i]);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }
}

/// Figma divider inside white panel: 8px horizontal inset, 1px border color.
class BuildSettingsDivider extends StatelessWidget {
  const BuildSettingsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingSymmetric(horizontal: 8),
      child: Container(
        width: context.width,
        height: 1,
        color: context.colors.cardBorderColor,
      ),
    );
  }
}
