part of '../../../imports/app_imports.dart';

/// Collapses to zero width with fade — shared by drawer rail rows (nav tile, profile, etc.).
class DrawerExpandableRowTransition extends StatelessWidget {
  final bool expanded;
  final Widget child;
  final AlignmentDirectional sizeAlignment;

  const DrawerExpandableRowTransition({
    super.key,
    required this.expanded,
    required this.child,
    this.sizeAlignment = AlignmentDirectional.centerStart,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: 250.milliseconds,
      curve: Curves.easeOutCubic,
      alignment: sizeAlignment,
      child: SizedBox(
        width: expanded ? null : 0,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: expanded ? 1.0 : 0.0,
          curve: Curves.easeInOut,
          child: child,
        ),
      ),
    );
  }
}
