import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/models/models.dart';

class CustomNavigationDestinationItem {
  final String label;
  final IconInfo icon;
  final IconInfo? cupertinoIcon;
  final Widget? iconWidget;
  final int? navigationIndex;

  const CustomNavigationDestinationItem({
    required this.label,
    required this.icon,
    this.cupertinoIcon,
    this.iconWidget,
    this.navigationIndex,
  });
}
