part of '../../../imports/app_imports.dart';

class DrawerExpandableNavigationItem extends StatefulWidget {
  final CustomNavigationDestinationItem item;
  final StatefulNavigationShell navigationShell;
  final bool isExpanded;
  final bool isSelected;
  final bool initiallyExpanded;
  final bool isWideWeb;

  const DrawerExpandableNavigationItem({
    super.key,
    required this.item,
    required this.navigationShell,
    required this.isExpanded,
    this.isSelected = false,
    this.initiallyExpanded = false,
    this.isWideWeb = false,
  });

  @override
  State<DrawerExpandableNavigationItem> createState() =>
      _DrawerExpandableNavigationItemState();
}

class _DrawerExpandableNavigationItemState
    extends State<DrawerExpandableNavigationItem> {
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _isOpen = widget.initiallyExpanded;
  }

  @override
  void didUpdateWidget(covariant DrawerExpandableNavigationItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isExpanded != widget.isExpanded) {
      _isOpen = widget.initiallyExpanded;
    }
    if (widget.initiallyExpanded && !oldWidget.initiallyExpanded) {
      _isOpen = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scale = DrawerScale.of(context);
    final isPortraitDrawer = !widget.isWideWeb && context.isAppPortrait;
    final usesLightDrawerChrome =
        !context.isDarkMode && (widget.isWideWeb || isPortraitDrawer);
    final chevronColor = widget.isSelected
        ? context.colors.onPrimary
        : (usesLightDrawerChrome ? AppColors.slate.slate700 : context.colors.foreground);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        BuildDrawerItemWidget(
          item: widget.item,
          isWideWeb: widget.isWideWeb,
          isSelected: widget.isSelected,
          isExpanded: widget.isExpanded,
          onTap: () => setState(() => _isOpen = !_isOpen),
          trailing: Padding(
            padding: EdgeInsetsDirectional.only(end: scale.r(4)),
            child: AnimatedRotation(
              turns: _isOpen ? 0.25 : 0,
              duration: const Duration(milliseconds: 200),
              child: Icon(Icons.chevron_right, size: scale.r(16), color: chevronColor),
            ),
          ),
        ),
        if (_isOpen)
          DrawerExpandableSubItemsList(
            subItems: widget.item.subItems,
            navigationShell: widget.navigationShell,
          ),
      ],
    );
  }
}
