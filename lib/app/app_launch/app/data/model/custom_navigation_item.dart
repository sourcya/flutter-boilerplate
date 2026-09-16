import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/app_launch/app/data/model/custom_navigation_destination_item.dart';
import 'package:flutter_boilerplate/core/models/models.dart';

/// Drawer / sidebar navigation entry. Add or remove items from [AppController.drawerNavItems].
class CustomNavigationItem {
  final String label;
  final IconInfo icon;
  final IconInfo? cupertinoIcon;
  final Widget? iconWidget;
  final int? navigationIndex;
  final VoidCallback? onTap;
  final String? route;
  final List<String> relatedRoutes;
  final List<CustomNavigationSubItem> subItems;

  const CustomNavigationItem({
    required this.label,
    required this.icon,
    this.cupertinoIcon,
    this.iconWidget,
    this.navigationIndex,
    this.onTap,
    this.route,
    this.relatedRoutes = const [],
    this.subItems = const [],
  });

  bool get isExpandable => subItems.isNotEmpty;
}
