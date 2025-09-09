part of '../../ui/imports/settings_imports.dart';

class QuickActions {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback tap;
  const QuickActions({
    required this.title,
    required this.icon,
    required this.color,
    required this.tap,
  });
}
