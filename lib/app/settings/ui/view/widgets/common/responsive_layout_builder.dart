part of '../../../imports/settings_imports.dart';

class ResponsiveLayoutBuilder extends StatelessWidget {
  final Widget Function(BuildContext context) mobileBuilder;
  final Widget Function(BuildContext context) tabletBuilder;
  final Widget Function(BuildContext context) desktopBuilder;

  const ResponsiveLayoutBuilder({
    super.key,
    required this.mobileBuilder,
    required this.tabletBuilder,
    required this.desktopBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (width > 1000) {
          return desktopBuilder(context);
        } else if (width > 600) {
          return tabletBuilder(context);
        } else {
          return mobileBuilder(context);
        }
      },
    );
  }
}
