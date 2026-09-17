import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/app_launch/app/data/model/drawer_app_module.dart';
import 'package:flutter_boilerplate/core/models/models.dart';

class CustomNavigationDestinationItem {
  final String label;
  final IconInfo icon;
  final IconInfo? cupertinoIcon;
  final Widget? iconWidget;
  final int? navigationIndex;
  final String? route;
  final DrawerAppModule? module;
  final List<CustomNavigationSubItem> subItems;

  const CustomNavigationDestinationItem({
    required this.label,
    required this.icon,
    this.cupertinoIcon,
    this.iconWidget,
    this.navigationIndex,
    this.route,
    this.module,
    this.subItems = const [],
  });

  bool get isExpandable => subItems.isNotEmpty;
}

class CustomNavigationSubItem {
  final String label;
  final IconInfo? icon;
  final int? navigationIndex;
  final String? route;
  final String? queryTab;
  final VoidCallback? onTap;

  const CustomNavigationSubItem({
    required this.label,
    this.icon,
    this.navigationIndex,
    this.route,
    this.queryTab,
    this.onTap,
  });
}
