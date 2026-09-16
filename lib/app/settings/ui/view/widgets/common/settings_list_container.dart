part of '../../../imports/settings_imports.dart';

class SettingsListContainer extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;

  const SettingsListContainer({
    super.key,
    required this.children,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final effectivePadding =
        padding ?? context.paddingSymmetric(horizontal: 16);
    return Container(
      width: context.width,
      decoration: BoxDecoration(
        color: context.colors.screenCardSurface,
        borderRadius: 16.radius,
        border: Border.all(color: context.colors.cardBorderColor),
      ),
      child: ClipRRect(
        borderRadius: Style.cardBorderRadius,
        child: Padding(
          padding: effectivePadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
      ),
    );
  }
}
